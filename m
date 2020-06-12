Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B745D1F7B02
	for <lists+linux-can@lfdr.de>; Fri, 12 Jun 2020 17:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbgFLPgr (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 12 Jun 2020 11:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgFLPgr (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 12 Jun 2020 11:36:47 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D380DC03E96F
        for <linux-can@vger.kernel.org>; Fri, 12 Jun 2020 08:36:45 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id j10so10179539wrw.8
        for <linux-can@vger.kernel.org>; Fri, 12 Jun 2020 08:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7dRt4KewET3WpQdL6VMn1u0ZKmH3ifb5IVwyVExy/0c=;
        b=o+xUTXd5lKXzg1rEIsMfIUB0R5jSkas9eyQ5T4LuxFqz4SRbLslbJZ/0CwqxYu741+
         UHEDDnxQC0Gz44l4ycA6AOPFH3TaKH3EoAlJ+h6uXGrZyW88AoNI00EUSZsAACurh0pQ
         DMG2YMT2vosHAhL9tfSeXER2LYzoNOGjz4zT/spK7UJ+ifCn+fH9tijVjuHueXRGMrjH
         xvrH0f/DQJVgaYSMc3qO8s9VYTSkEXhK+cd5YSZtHmYNRh4yWQtKwNzCtdAKUOekYR4U
         FD7ls7XIGw3hH7gDV6TRHL+CyLRf7wsaeiuPhMznlq6Sgn6hcG3TIiyIYDxYTB58nb2p
         rOYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7dRt4KewET3WpQdL6VMn1u0ZKmH3ifb5IVwyVExy/0c=;
        b=bjz/POg8Y5M752q4UFjnxCZwnzWjiGodxbxz2C+CrauZiSe8L/m097fVRd/lEOUK3D
         TMMZH1UaJWGvpyTSLXQUXewtuYrZA8i6/DO+3WtYbFe22CVcAxSPh++krgtFoGT59emv
         Z2y8uYDj6zhP8T9rQbvN2sC4olyG08MBfyVgEPRISToa/7tcZrTPCkk6ZIW+9RWICUxD
         nBIXHZXoimzyDyz/aHiqEioDSfB/Sop30DhdId1F3PJ8HAikb9vYWQEo/Y1XconlgJ0h
         dG/60RG+9nCaUpgNZDjqDOB93DsBE7Aq48rGvjoazhNYZapTZgwkSU8T/XKFpzqxraw3
         5l6g==
X-Gm-Message-State: AOAM531p+AXWD653uhV/Vc22mYd87D5FIokAILDnCaC+v4U2VD3kHybN
        jf2hGVfg2fIytOCD1nbe2+Bi4w==
X-Google-Smtp-Source: ABdhPJwdF7a+uqVvXTJu52Y5AHTgnt3tPetvLcmXi+cWGpJ3auc5wwh12w3uHbCyq/dn/lF0/zlHnw==
X-Received: by 2002:adf:ed51:: with SMTP id u17mr14503889wro.285.1591976204477;
        Fri, 12 Jun 2020 08:36:44 -0700 (PDT)
Received: from x1 (i59F66838.versanet.de. [89.246.104.56])
        by smtp.gmail.com with ESMTPSA id z22sm9414610wmf.9.2020.06.12.08.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 08:36:43 -0700 (PDT)
Date:   Fri, 12 Jun 2020 17:36:41 +0200
From:   Drew Fustini <drew@beagleboard.org>
To:     Patrick Menschel <menschel.p@posteo.de>
Cc:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: isotp in mainline?
Message-ID: <20200612153641.GA3433528@x1>
References: <20200611154337.GA3166627@x1>
 <9d3bcfde-68f3-c9e0-4c63-cbae61915585@posteo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d3bcfde-68f3-c9e0-4c63-cbae61915585@posteo.de>
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Fri, Jun 12, 2020 at 03:47:45PM +0200, Patrick Menschel wrote:
> Hi Drew,
> 
> > Is there a current effort to get the isotp driver accepted into mainline?
> 
> I believe ISOTP has been mainline for quite a while.
> 
> I remember writing a test script when Python 3.7 came out in Aug 2018
> and added the isotp socket type to socket class [1].
> 
> I tested on a X86_64 machine with Ubuntu 18.04 LTS, so it must have been
> mainline at that time.
> 
> Regards,
> Patrick
> 
> [1]
> https://docs.python.org/3.7/library/socket.html?highlight=socket#socket.CAN_ISOTP
>

Hi Patrick,

Maybe it was just to a test to see if the the protocol type existed?

It does look like the protocol is defined in include/uapi/linux/can.h:

#define CAN_ISOTP	6 /* ISO 15765-2 Transport Protocol */

However, there does not appear to be any implementation in the mainline
kernel.

I recall Oliver mentioning that he should try to mainline isotp modules
at the end of the J1939 talk at ELC-E last October [1]. I don't see any
posts regarding isotp in the linux-can archives since then, so I thought
I would bring it up.

Thanks,
Drew

[0] https://elixir.bootlin.com/linux/v5.7/source/include/uapi/linux/can.h#L159
[1] https://youtu.be/3NfN8B4-w8w?t=2052
