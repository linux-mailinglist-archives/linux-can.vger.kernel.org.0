Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 713E4620A2E
	for <lists+linux-can@lfdr.de>; Tue,  8 Nov 2022 08:31:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233436AbiKHHbT (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 8 Nov 2022 02:31:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiKHHbS (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 8 Nov 2022 02:31:18 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DBB6167D0
        for <linux-can@vger.kernel.org>; Mon,  7 Nov 2022 23:31:18 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id g12so20024116lfh.3
        for <linux-can@vger.kernel.org>; Mon, 07 Nov 2022 23:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1G4HH/Un4Ldw4Kg9mAfztEcm3aw8Ky8DnIHt266GhrM=;
        b=bn31pW0bLuEvW8tfclQguCs2OTjmTcwwNfsBA8RNTMk9240IWp6b2lVEb7T1XZ744e
         gxH/krUEZSwExZ1lj+lujqw0lfytAF+WtJ1EvBq1ifunB4q5LRmdET3xaMZiq9TEYQOb
         crxUxz/7c+u4P+3OGlwyCAHV8uZJv4YeUNCf1ABJdHicB2I9PhX5XkQwe6ELvp8hpF8S
         TNKBU3uZa5s50STdM2R/rNv4uozrXhUSSZf8ogxNNuHdeN70ca3Ze9Wpwx8Ik+RsWoVQ
         Vw+Tvtm8i76iy57IAoHznFg6lK109b1WiKoNF45GGCyqiTlKFfpPqi2Ue9bSMbGxWty0
         w1ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1G4HH/Un4Ldw4Kg9mAfztEcm3aw8Ky8DnIHt266GhrM=;
        b=Z8WenIhP3fAOVN9LM1y1oc+pc9OTgBOf3y18kZ6hdg9Re6orkb2daoRMk9cruSKemk
         gckgoUTSFibwMexuH2jtGhqa+uCgArCMxLhk0p1+M/s7wKrcIx9HeB5FLjjc1/A8iVOv
         c+GAx7DpZYi7TKFXbRgkrJhSOd2s0StfxoKduDHRmNJzy9L2SFbDTrWXZoa2M5JT+2Rg
         LJprlJLvnT+LryqxITahIVkVI1buOxSwSKgND5bSoctQOQmQ+btNgVu/fzRdo5qxUVnE
         ksG+NVxVQln3DKzGyuRFYL2Lu/L2IOUsY5TjjdfTuh2TPIdoSfGZ+IehYX5ewkWMuEVY
         Smrg==
X-Gm-Message-State: ACrzQf123pG9H/2I4NpT3WD/cO7g4Tg+BDIC00iuP6dodQOX9Zt/3uz2
        DpCwD1mEUc0o3SAFUBKbNWw6r41hFrBrhiimjtQ=
X-Google-Smtp-Source: AMsMyM4y694psFdvsh7e1mY2W2Rs2e+BX3HXYKnB/rK00BXQkxFDkOfw+EEOdljgWyxBxrqvLcPp90xDmsZ9T+GhwFQ=
X-Received: by 2002:a05:6512:252b:b0:4a0:5642:dbc5 with SMTP id
 be43-20020a056512252b00b004a05642dbc5mr20453941lfb.436.1667892676354; Mon, 07
 Nov 2022 23:31:16 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6022:1d9:b0:32:78fe:502 with HTTP; Mon, 7 Nov 2022
 23:31:15 -0800 (PST)
Reply-To: Vanessagomes0000@outlook.com
From:   Vanessa Gomes <jp2364930@gmail.com>
Date:   Tue, 8 Nov 2022 07:31:15 +0000
Message-ID: <CAFpYN5-UGi-cgEv0aQVB5oaZUdKsgyOnGz23H2Yu-1thzD2Qxg@mail.gmail.com>
Subject: ///////'//////////Ugrent
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:12f listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [jp2364930[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [jp2364930[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [vanessagomes0000[at]outlook.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Can i trust you on this transaction?
I have important business to discuss with you as soon as possible.
This proposition will be in the best interest of you and me both.
