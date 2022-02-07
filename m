Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B65694AC2DD
	for <lists+linux-can@lfdr.de>; Mon,  7 Feb 2022 16:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234628AbiBGPUl (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 7 Feb 2022 10:20:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392322AbiBGOyJ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 7 Feb 2022 09:54:09 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2CCEC0401C4
        for <linux-can@vger.kernel.org>; Mon,  7 Feb 2022 06:54:08 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id 192so14513275ybd.10
        for <linux-can@vger.kernel.org>; Mon, 07 Feb 2022 06:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=esQoHIXBUKeWlBb18gKIHyQyGBz/GVasu56Sd80B2ng=;
        b=NXZLADXqUp0MUL87f2/h9T5AZFn36uTfKE/g+cxCA/fcXOh0GtD/tqns5X6ZG5vBb2
         ZFlf1AsXdmKlgPriNORNLH50yMtdqxQ6hOZ197PBUqQruCcnS0RXL+xF+dnQwr6lJ3ZD
         R2jDsfICg+kT736d/znyp3riLsc45Ib1eqFSLy1h1rLhqXWV/1JieCvFNfJSlrWPsjgG
         vjn05pUXzgr+udhHRunJLyBJE8L4BjBueVbGbtvk+PBK9+XgPffkhqPSFdzuy9z1WJT0
         /RTZ+PNheQlpq+zevsjsA7Xdo5VzoeAwLdbtqPjfjF6bp57dF9M1StDfcG+TVYAuu1Ys
         JsZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=esQoHIXBUKeWlBb18gKIHyQyGBz/GVasu56Sd80B2ng=;
        b=KJ2exB6zugMIagnrrd2Vod1tWBrzfLXYQN0o+Ct4TA42SaeycL2tnEgJz7F0cve5hD
         j0XfTs2kKqUjXdwyqae2eDNxkfvo+/gglHILhsHd2kbNCsZMw5EmOk77G/NR33LjwYq+
         7QJAWLdSpCpHVW5pqwHMFKITH4ER393Og+yEbXK4usY9I+GbzC7Q/WWRm3UU46knJRc0
         z8sTA98VMKCM5qFUkv4FwLpnZ/K5pdqq4o+dHi7nqx0vPlwFPd6WZxNDLvvDqEJdYFzP
         GMgTutDj363/wQXKLJoXy+RlXZGzIVo5DxsQUxAE4w0vZyiCWn92yhD92KD/bxVJc5b7
         Cs5g==
X-Gm-Message-State: AOAM532KRVdVVIlotcJDA49FYTFJHTnvBFzjfr75BHwK6TAGzKaBsL+7
        F3Ga7EilLpGAV2I7nVUeZ5Lurs+vxAjTejbHu29+wUcf1l4O3Q==
X-Google-Smtp-Source: ABdhPJwyjojZbZLSz96+eLILLBrCNDMpkVn/7RMLww9UP1UOQ8KZY6aRUXRmVeU553jV0E9WbViIzv9in2lugkd7GDc=
X-Received: by 2002:a25:e0d5:: with SMTP id x204mr44368ybg.224.1644245493370;
 Mon, 07 Feb 2022 06:51:33 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7010:6713:b0:208:f944:4664 with HTTP; Mon, 7 Feb 2022
 06:51:32 -0800 (PST)
Reply-To: lindajonathan993@gmail.com
From:   Miss Linda <ikennaubochi9@gmail.com>
Date:   Mon, 7 Feb 2022 14:51:32 +0000
Message-ID: <CACFJyUCmF8Lu2XX=2f-sAXrHE5Y2rKTnvyTLfs2o8JeNfO_owg@mail.gmail.com>
Subject: Hi my love
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.9 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:b31 listed in]
        [list.dnswl.org]
        * -0.0 BAYES_40 BODY: Bayes spam probability is 20 to 40%
        *      [score: 0.2949]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [ikennaubochi9[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [ikennaubochi9[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [lindajonathan993[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.4 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  3.2 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hey dear

Nice to meet you, Am Miss Linda I found your email here in google
search and I picked
interest to contact you. I've something very important which I would like
to discuss with you and I would appreciate if you respond back to me
through my email address as to

tell you more about me with my
photos, my private email as fellows??   lindajonathan993@gmail.com

From, Linda
