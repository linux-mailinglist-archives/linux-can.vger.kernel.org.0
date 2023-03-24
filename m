Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 159026C82AE
	for <lists+linux-can@lfdr.de>; Fri, 24 Mar 2023 17:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbjCXQ4L (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 24 Mar 2023 12:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231839AbjCXQ4K (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 24 Mar 2023 12:56:10 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C0D12D
        for <linux-can@vger.kernel.org>; Fri, 24 Mar 2023 09:56:09 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id p203so2934502ybb.13
        for <linux-can@vger.kernel.org>; Fri, 24 Mar 2023 09:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679676969;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/hldnmZsxI6STeMly6M1GZxdok1Qf0nxjxXh00EY1v4=;
        b=jRSF9ACUxgYOKtVsRgFO6bWaaB04YaEJZqBLCzxW9AioOJPld/NT4Klv0k+IVS+jg6
         0/q8DBAans0cJ56Kq5KXJTGgREZCd+m46fZRqrfg/Vbx87FqcfLzJyUlIwYKxUkUmsLN
         ZvrVmRJK2KKf+Q9DZtvBaghnZiXiAQj8jWm9UCwff9YIn59UFsKDBQ2L5wDQSw07fiQL
         qRVO/yReS1EVZc+Bv/PTzc5JYxlvunOWJNGHMZhg7PmQV5Cgkd5THcGAyDt3HY+yWK4j
         uou6j+KL2/T6gz143biJvL3E1UADwJ1+Mx0WJq1xucffbKkrA8Nw+0aIWJHupX2ExuRY
         RWwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679676969;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/hldnmZsxI6STeMly6M1GZxdok1Qf0nxjxXh00EY1v4=;
        b=XRyH2WKLezts9UISUVQMgszN4dF05R43qtp+vYsD/VHV4NBRPhZ0NQYkxezsU/CXYd
         A1BAdz5Jx6bscHUkk0/MbMsWHtMkgNTUtzrZPyswJYESOngEkbyYsOKJvd6LR65SvGgM
         2jqNffi8Nd4zU8Yc0bwvCSA7fwpFQQnCmqYoUZSQSR/UVuqi1uy+oSEcnkf+WtpJrNFq
         XKuYH1LQYKyiwYUsvnM6llZl00NOn9HENdhiT5msz4vk/1TNKCljq2Z/R7SQstnG+Jpl
         rkWOV/FHlvxAk/oj3tpirAJRmV+QiWjpHXaOOdVrtCQmlCAo5vvdvQFh7ZoKCZlEgB2R
         5SPA==
X-Gm-Message-State: AAQBX9e2aaUCMKzQGJv4FET6JJUlr5tvPptVJQ0lxT9Vs7jnZQHqcyce
        quPABSTWPd5c/UqOO1TrRrv32lyOoaAUxezw5NWkhcMI0ek=
X-Google-Smtp-Source: AKy350ZljrTdbn+O95j9WWpal0+RQAZ0Gw7ViROhby6xViP+GPvYbaSYonNMEUCsHmI9o+5YsACfp2NGy4NojB88scs=
X-Received: by 2002:a05:6902:709:b0:b21:5fb4:c6e6 with SMTP id
 k9-20020a056902070900b00b215fb4c6e6mr1462018ybt.11.1679676968788; Fri, 24 Mar
 2023 09:56:08 -0700 (PDT)
MIME-Version: 1.0
From:   Quinton Cook <quinton.cook@gmail.com>
Date:   Fri, 24 Mar 2023 09:55:58 -0700
Message-ID: <CAAL29+00Rur1AWfj-gbzTo2afyYgsg-zY0B9rvgPoPaLaz8wNw@mail.gmail.com>
Subject: J1939-22
To:     linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello my name is Quinton Cook. I was wondering if anyone was planning
on implementing the new J1939-22 protocol in the linux kernel? If not
I would love to implement it! Any help on getting started with linux
kernel development would be greatly appreciated.

Thank you and have a great day!
