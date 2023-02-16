Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB445699F1D
	for <lists+linux-can@lfdr.de>; Thu, 16 Feb 2023 22:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjBPVqK (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 16 Feb 2023 16:46:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjBPVqK (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 16 Feb 2023 16:46:10 -0500
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 589D8442CF
        for <linux-can@vger.kernel.org>; Thu, 16 Feb 2023 13:45:33 -0800 (PST)
Received: by mail-vs1-xe33.google.com with SMTP id j40so1464054vsv.2
        for <linux-can@vger.kernel.org>; Thu, 16 Feb 2023 13:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1676583932;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w+ocBNrNCUm5aE7elb8BeJRIn6ryZfZu4ud6FDTnrHg=;
        b=V2W+bvFO02K+9Zv1X1mdAiIRGKZ6OusYIdT3a82EJbIT2GlgisttD4LxAuil0vXVCp
         6zIFAVTzpR2lp4FZwXtJKmcjId+TDNiYjlgYoi0Vs55FdEgxvr7ZgHAnF3aiGBQ7TJqc
         th32eKOpAawr41eA1k7qyDxlPGLNgH342OpbhaDDbYQm/RzVn+E3r8oJ3flKAtNyO2Fk
         smAbmxrrdA0vOj8NkHYF+V3nI8ysnsAqjRKF0G9SF7EypU4uhyIlUJwTTYYtKLVmo00Z
         fCNqSXZQfUX+B5olGqB1xDtF5A3w9Ki2fiuzW2dXRj4wulOyOY4HF6Y/O1NeK9EsKWJE
         V57A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676583932;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w+ocBNrNCUm5aE7elb8BeJRIn6ryZfZu4ud6FDTnrHg=;
        b=sHkO2zJrffw9f6ghFxZtXYxHKnQEBhv7+NaNYAPbNItCcWJG6xzW+3TMHpz6KQXT3S
         mEm5uTB/sTcVN40+ITV0UF317pGeKKDXsfutOoJsFLxVCg6kJ36OcgVSLyUCiQnHHJAK
         DeRkjfImvMbJepqxdFmWax5yr55vC8miwbxCfwHGt/QeNyMm54cQuw35zE5sW/jEFZcE
         tB9dnZ116JJZkojtbEN3U4rGL1Om0gs63LJBwbNWQouf0jdHYfsHF+xYsl4lgIgfurzm
         mCo4a56YrWYa/BLPfPQkmIVb4q4heItwDbI/QCbfoXrJCvp1YJgatYPBDDKrG7ge8yux
         sJRg==
X-Gm-Message-State: AO0yUKWY5gwlr3tRAr+YtEM23mBWwmKRRQ2JJiOcpm/1vzJQWwk/m9I+
        sA8VN41LmOycRJlwja/OKifgM1Aco9VtUyuZ+6U=
X-Google-Smtp-Source: AK7set9Nh9Q/Ju0WUeMDIzwYu3NvTixQDdb7x486eiLLwkZ77yW8HqHiS9O07drZbuSzls+sd9DLozIZBVY7yBlnvms=
X-Received: by 2002:a67:dc18:0:b0:3d0:d3fe:3d48 with SMTP id
 x24-20020a67dc18000000b003d0d3fe3d48mr1136119vsj.32.1676583932251; Thu, 16
 Feb 2023 13:45:32 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ab0:134a:0:0:0:0:0 with HTTP; Thu, 16 Feb 2023 13:45:31
 -0800 (PST)
Reply-To: mrslorencegonzalez@gmail.com
From:   "Mrs.lorence Gonzalez" <jameswilliamsfernandez0@gmail.com>
Date:   Thu, 16 Feb 2023 13:45:31 -0800
Message-ID: <CAOD8V8OEs+WN2cD8L0s-zR63CFGamCs-H+r0W191v8iZs4ciTA@mail.gmail.com>
Subject: Mrs.lorence Gonzalez
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_HK_NAME_FM_MR_MRS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello My Dearest One,

Am a dying woman here in the hospital, i was diagnose as a Cancer
patient over  2 Years ago.
I am A business woman how dealing with Gold Exportation. I Am from Us
California I have a
 charitable and unfulfilled project that am about to handover to you,
if you are interested
please reply.

Hope to hear from you.

Regard

mrslorencegonzalez@gmail.com

Mrs.lorence Gonzalez
