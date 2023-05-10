Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E28DF6FE2A8
	for <lists+linux-can@lfdr.de>; Wed, 10 May 2023 18:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbjEJQke (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 10 May 2023 12:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231455AbjEJQkd (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 10 May 2023 12:40:33 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71FEC7D97
        for <linux-can@vger.kernel.org>; Wed, 10 May 2023 09:40:32 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-24de3a8bfcfso7100830a91.1
        for <linux-can@vger.kernel.org>; Wed, 10 May 2023 09:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683736832; x=1686328832;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1UOgzSvtfIYtogGhSv4WvatrHpjkP4seObNNVkIByeM=;
        b=TwCycTTQew3kCZ2DVYZu17L744OM5q8t1mGMPHEODndWeX1xM4fQ0vnKunRKSGRsSr
         dqG7yYKXYuYJhKmp8WNVU6IGzhXPoM7gvxgfnK459VPsA3uhckKDdZKYRXaShKy0oQig
         v/IJ8XsZf0G8oLjmWAfXLoMFpp/gJyLg9Lpcl4zbq5lO66HHLKJ4Vg6dH9JOKEYbs+81
         lTEqFcXJkTlLMQFH1/L6vpgES2dkCbj2HlezD82VSajPetwFJd05o+ly4ODlfURutYft
         79x8FWsgHKLckxIG1S37wJ/f+akQIGT79mSwyg8GmyONdWAyQOPGLCclJ3lcpJjW65tD
         NuXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683736832; x=1686328832;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1UOgzSvtfIYtogGhSv4WvatrHpjkP4seObNNVkIByeM=;
        b=lyoSxnpzYUYwVXnQop+9PJ5FBHRfc6h7dUIFZ1jRQsr/dSDsWzLmIJSrfwRcOL+L3g
         BVFfoLCOMG+CzvgehpUeyZr5/i3hd1OSFhFlN/GgzF/Kkd1YhKistHv5owlUdJGnw7Vc
         9Mj7rWwOIQuV3gmcW5a10ZMCNu1SrmFofzcRQnlg0E0wErcbuMWOdwLSnCt17kS2Qiut
         3y/UybtEzq52Gp+3Op1CdXEKjeM7OvmKZrazVdMPuDQYbLhUZ+Ixuabv2GXREdcq7oNF
         dVXVERjtby7HPIegJyhpMsdO5cY4LhQ3ECCyXPeRiFyyX7KFERWC8w9ZZDqyXo3neL/d
         qtqg==
X-Gm-Message-State: AC+VfDxccttLROQ3QPqDkVMFltJ6IPdleOoKiNqWxD+SA5jRcnvWuGuK
        o1iPdwDE8Wh9yvqiwkGZnx7ZWm/4VhUM3pM8rtg=
X-Google-Smtp-Source: ACHHUZ6C72QCFouJwLmTwBdSsExxhGh892FFsqhECw5dHLJL983zOhlnLJ2xYj9sU4SGGLZiInrQWl556Pqka0vsBXs=
X-Received: by 2002:a17:90a:13ce:b0:24e:3ed9:23a1 with SMTP id
 s14-20020a17090a13ce00b0024e3ed923a1mr18854974pjf.28.1683736831572; Wed, 10
 May 2023 09:40:31 -0700 (PDT)
MIME-Version: 1.0
Reply-To: johv19344@gmail.com
Sender: drmusazongo11@gmail.com
Received: by 2002:a05:7022:ff46:b0:62:58f8:8f45 with HTTP; Wed, 10 May 2023
 09:40:30 -0700 (PDT)
From:   Van Der Kuil Johannes <johv1934@gmail.com>
Date:   Wed, 10 May 2023 16:40:30 +0000
X-Google-Sender-Auth: sXlod98ZqVaynpbNrVFVg3nUW8g
Message-ID: <CAGKduDyGDq0o=yYh_YHWfjLU=KoXgfuvVkatPy0Mpjs=+GieSA@mail.gmail.com>
Subject: With Due Respect
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.0 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi! How are you?  My name is Van Der Kuil Johannes Gerhardus Maria.  I
am a lawyer from the Netherlands who reside in Belgium and I am
working on the donation file of my client, Mr. Bartos Pierre
Nationality of Belgium. I would like to know if you will accept my
client's donation Mr. Bartos Pierre?
