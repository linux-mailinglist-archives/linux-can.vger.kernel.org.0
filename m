Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCF416216CF
	for <lists+linux-can@lfdr.de>; Tue,  8 Nov 2022 15:32:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233826AbiKHOcV (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 8 Nov 2022 09:32:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233908AbiKHObl (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 8 Nov 2022 09:31:41 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0927258BFB
        for <linux-can@vger.kernel.org>; Tue,  8 Nov 2022 06:31:16 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id c8so10307003qvn.10
        for <linux-can@vger.kernel.org>; Tue, 08 Nov 2022 06:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SzBlYeGeT15Xra75w9IZDBjQ7Da3XKSmRdlnDJDYrko=;
        b=plCZMl07mNxOy4FwEnJyPWecERqsJQyrHYHIsHPByWrtU1k24II845ABLvzsZ/utuV
         xrfZ6D/e/ZRoyRjpbZ5oMDY9h9ndbu6gtWFiQs/CjHcVVSqci/vjYPMMyy1pnVJ69u5N
         OM2Kwkcs/9db1KNzWi4t4Kki8xmdjDy37F969+9phg4q7Iutyq/zyteGqROU9T6wdO4n
         lS/c2RFkn8H1h3UlswE5jNY6oMt5wQG8oq965L41J8fDh6fe1zek7KZifUk151Do70De
         k9oKwcRkEhDvguAg4zcTYagV5rrGsvTLwyNtdWlzI5EY/CPrjAga8S7nNTzf3DHImH9S
         a/jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SzBlYeGeT15Xra75w9IZDBjQ7Da3XKSmRdlnDJDYrko=;
        b=ojRyRhPPnItioU4+awPSxvIUKd4ISie9AQbaQLhxQGhypLSVLKdgyT3SAuhg2Gvb3q
         a3037lpOEcbmCdgQ2zMpt8f7EZ7Al37xXSAChlv8H6HI6EllTSV3IWxMl2UxXbWaI8By
         hx2V1KIItMJlOg0DuaMne4blJ7YHxv99NwY5pzI5EH5nMK5pxD+6dizlbECCAAGvivqy
         32B6K/b3hBuvLv0OSsZDFkD/yYUIfXusSh+C0oHwz2uO1fVW1i5QcM84QXFA0ZqPb+V1
         KA+IXFj2VwPl6irm5vDRVYvodM7Wc1wic2E6N6IKJ65d7tnySGCYV5kCxRU9y/gyRcZ+
         hr8g==
X-Gm-Message-State: ACrzQf23zv8u3TPPOYcZrKzJLWk9mGUyX2BWk5s/Ty+J6BvFsvBw1bKH
        go5klvlniLRYI+/CLWVmOrESTVqcP+hbn1ZLp5iIK6brKUkfNg==
X-Google-Smtp-Source: AMsMyM5cpw1VKvG8gEasOMmG4UhkblJY7gBReqfbYX80x9OXEWSZokzXOm90JDY4L5h3JbfU+3ckCU+QNWhG8SGrNVo=
X-Received: by 2002:a05:6a00:1da6:b0:56c:318a:f8ab with SMTP id
 z38-20020a056a001da600b0056c318af8abmr56843835pfw.82.1667917864342; Tue, 08
 Nov 2022 06:31:04 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ac4:c8c2:0:b0:56a:d900:eb11 with HTTP; Tue, 8 Nov 2022
 06:31:03 -0800 (PST)
Reply-To: mr.abraham022@gmail.com
From:   "Mr.Abraham" <davidbraddy01@gmail.com>
Date:   Tue, 8 Nov 2022 14:31:03 +0000
Message-ID: <CAHGOU4PvdrNhE2KifzdPkFxZTCG5gy+23qf130PwnSmJcLRSew@mail.gmail.com>
Subject: Greeting
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:f35 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4954]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [mr.abraham022[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [davidbraddy01[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [davidbraddy01[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

My Greeting, Did you receive the letter i sent to you. Please answer me.
Regard, Mr.Abraham
