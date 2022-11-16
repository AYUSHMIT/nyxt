;;;; SPDX-FileCopyrightText: Atlas Engineer LLC
;;;; SPDX-License-Identifier: BSD-3-Clause

(uiop:define-package :analysis/tests
  (:use :cl :lisp-unit2)
  (:import-from :analysis))
(in-package :analysis/tests)

(define-test test-single-length ()
  (let ((model (make-instance 'analysis::sequence-model)))
    (analysis::add-record model '(1 2))
    (assert-equal (analysis::element (analysis::predict model '(1))) 2))

  (let ((model (make-instance 'analysis::sequence-model)))
    (analysis::add-record model '(1 2))
    (analysis::add-record model '(2 3))
    (analysis::add-record model '(2 3))
    (assert-equal (analysis::element (analysis::predict model '(1))) 2))

  (let ((model (make-instance 'analysis::sequence-model)))
    (analysis::add-record model '(1 2))
    (analysis::add-record model '(1 2))
    (analysis::add-record model '(1 2))
    (analysis::add-record model '(1 3))
    (analysis::add-record model '(1 3))
    (assert-equal (analysis::element (analysis::predict model '(1))) 2))

  (let ((model (make-instance 'analysis::sequence-model)))
    (analysis::add-record model '(1 2))
    (analysis::add-record model '(1 2))
    (analysis::add-record model '(1 3))
    (analysis::add-record model '(1 3))
    (analysis::add-record model '(1 3))
    (assert-equal (analysis::element (analysis::predict model '(1))) 3))

  (let ((model (make-instance 'analysis::sequence-model)))
    (analysis::add-record model '(1 2))
    (analysis::add-record model '(1 3))
    (analysis::add-record model '(1 2))
    (assert-equal (analysis::element (analysis::predict model '(1))) 2)))

(define-test test-multiple-length ()
  (let ((model (make-instance 'analysis::sequence-model)))
    (analysis::add-record model '(1 2 3))
    (assert-equal (analysis::element (analysis::predict model '(1 2))) 3))

  ;; Make sure the most temporally recent element is used
  (let ((model (make-instance 'analysis::sequence-model)))
    (analysis::add-record model '(1 2 3))
    (analysis::add-record model '(1 2 4))
    (assert-equal (analysis::element (analysis::predict model '(1 2))) 4))

  (let ((model (make-instance 'analysis::sequence-model)))
    (analysis::add-record model '(1 2 3))
    (analysis::add-record model '(1 2 4))
    (analysis::add-record model '(1 2 4))
    (analysis::add-record model '(1 2 4))
    (assert-equal (analysis::element (analysis::predict model '(1 2))) 4))

  (let ((model (make-instance 'analysis::sequence-model)))
    (analysis::add-record model '(1 2 3))
    (analysis::add-record model '(1 2 4))
    (analysis::add-record model '(1 2 4))
    (analysis::add-record model '(1 2 4))
    (analysis::add-record model '(1 2 3))
    (analysis::add-record model '(1 2 3))
    (analysis::add-record model '(1 2 3))
    (analysis::add-record model '(1 2 3))
    (assert-equal (analysis::element (analysis::predict model '(1 2))) 3)))

(define-test test-variable-length ()
  (let ((model (make-instance 'analysis::sequence-model)))
    (analysis::add-record model '(1 2 3))
    (analysis::add-record model '(1 2 4))
    (analysis::add-record model '(1 2 4))
    (analysis::add-record model '(1 2 4))
    (analysis::add-record model '(1 2))
    (analysis::add-record model '(1 2))
    (analysis::add-record model '(1 2))
    (analysis::add-record model '(1 2 3))
    (analysis::add-record model '(1 2 3))
    (analysis::add-record model '(1 2 3))
    (analysis::add-record model '(1 2 3))
    (assert-equal (analysis::element (analysis::predict model '(1 2))) 3))

  (let ((model (make-instance 'analysis::sequence-model)))
    (analysis::add-record model '(1 2 3))
    (analysis::add-record model '(1 2 4))
    (analysis::add-record model '(1 2 4))
    (analysis::add-record model '(1 2 4))
    (analysis::add-record model '(1 2))
    (analysis::add-record model '(1 2))
    (analysis::add-record model '(1 3))
    (analysis::add-record model '(1 3))
    (analysis::add-record model '(1 3))
    (analysis::add-record model '(1 2 3))
    (analysis::add-record model '(1 2 3))
    (analysis::add-record model '(1 2 3))
    (analysis::add-record model '(1 2 3))
    (assert-equal (analysis::element (analysis::predict model '(1))) 3)
    (assert-equal (analysis::element (analysis::predict model '(1 2))) 3)))
