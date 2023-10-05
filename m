Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB2677BA6E9
	for <lists+linux-can@lfdr.de>; Thu,  5 Oct 2023 18:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbjJEQnU (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 5 Oct 2023 12:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234554AbjJEQl7 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 5 Oct 2023 12:41:59 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5655AD3A
        for <linux-can@vger.kernel.org>; Thu,  5 Oct 2023 09:30:45 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-2799b7280d1so888881a91.1
        for <linux-can@vger.kernel.org>; Thu, 05 Oct 2023 09:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696523391; x=1697128191; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=78u/4AcH37Ns3ez0KXHw64klEWNy2+xiSAb6r9kIN0U=;
        b=RPEGlzUWrGrHZF957UMiOtmg6ay5cOaW74n2SBOaJ7LTAEd3fPL39swXiEvMh8zSNe
         hFWdHeE1ueeTYnumoAWaLWrm6Fj76x4dAjWgo8o1RhGD0sb4GLrkSt+tBSbmVTX9baNA
         wgExePaSSaVixLmkd0x/LcEMuMZlVLG4n0nC7fTOk/W1iIbwYyn4um/xMq+/AbTXwb3A
         qHf5L92zvadLeMp7oL70YXaN0EqY0KjpuQbylciKqycIMaeVyRoEfmBgv8ntUGg29c5w
         vtKAxEwuWpvc5GZXOMiJ+pKiSnrjGyblyiFuFLPcWbwc3zJoOEeiXX32UilnBo6nOb+4
         jFzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696523391; x=1697128191;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=78u/4AcH37Ns3ez0KXHw64klEWNy2+xiSAb6r9kIN0U=;
        b=n0FosRNTPKxHVxeDrVMbUcfUmSICaeLnNH0SmYf2zCrowekM1eTNc2iLbVv24wMCw9
         76nuy4Z3ZRb6J2XL+jE+Tgur1d0PdOXyY8aBugxh3f1rtpfiJwM7lBWHTVLmF2YdTcOp
         ThQIKk04p15w0e4IYxwLebP5oVHkF0G3CCY5QpzsoTbz/exyaJ++DxoKeKlk+PLjztAH
         WjpFyn/5jIs0AoSm+U6ClwONTi/6jP9169HDY7yDLQ+AjoP+1JKhf1pqhjpH2NMwpsGN
         B+sHlVauv1GA3upFUQWGlLZUdPclGk50H6X8pj8htk1t62wOtQ/E8BVvqCxXWYkRrwqI
         tdLA==
X-Gm-Message-State: AOJu0Yxj8K0pDktqT1eqS+0M9qneo7D8FQyE2EH4MTebmHzkiwzFXgSb
        p3BXLUu4vfPTzYvWhAv/Ys/3LCpz1FOrxY+4H5k=
X-Google-Smtp-Source: AGHT+IEWpZUMzJfV7+IQSij4Egv6wiIqJ3+YU74pjI9gcD21+29cWl17GxsUOz7HlKqo5n7tnEQgEytQXHYYkW3sx24=
X-Received: by 2002:a17:90b:4f44:b0:26d:5cd0:979f with SMTP id
 pj4-20020a17090b4f4400b0026d5cd0979fmr5604674pjb.43.1696523390625; Thu, 05
 Oct 2023 09:29:50 -0700 (PDT)
MIME-Version: 1.0
References: <20231004-at91_can-rx_offload-v1-0-c32bf99097db@pengutronix.de>
 <20231004-at91_can-rx_offload-v1-27-c32bf99097db@pengutronix.de>
 <CAMZ6RqLoyCOsTuYCryr++yZw036cF2VyEbxawQSKvM-54aaHuA@mail.gmail.com> <20231005-overfull-chirping-9900063427f4-mkl@pengutronix.de>
In-Reply-To: <20231005-overfull-chirping-9900063427f4-mkl@pengutronix.de>
From:   Vincent Mailhol <vincent.mailhol@gmail.com>
Date:   Fri, 6 Oct 2023 01:29:38 +0900
Message-ID: <CAMZ6Rq+v=DqZ1+T+tyN0n5hQRd0Av2APW8OWpEFbKXQsS8itpQ@mail.gmail.com>
Subject: Re: [PATCH 27/27] can: at91_can: switch to rx-offload implementation
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org, kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Thu. 5 Oct. 2023 at 16:28, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> On 04.10.2023 21:55:41, Vincent Mailhol wrote:

(...)

> > If I understand correctly, you only use the hardware timestamp for the
> > napi but you do not report it to the userland.
>
> ACK
>
> > Not a criticism of this series, but it seems to me that it would be
> > easy to add one follow-up patch that would populate
> > skb_shared_hwtstamps->hwtstamp and update ethtool_ops->get_ts_info in
> > order to report those hardware timestamps to the user.
>
> Yes. I have proof-of-concept patches for it laying around, but I want to
> get this mainline first. One limitation of the hardware is that the
> timer is only 16 bits wide and runs on CAN clock, which means a maximum
> of 1MHz. This causes the timer to overflow every 64ms, which in turn
> requires a worker every 30ms or so.

ACK.

> For this reason, I want hardware TS
> to be configurable and this is not yet implemented. Also $CUSTOMER
> doesn't need HW timestamps :)

Actually, this is already available in the kernel. You just need to
implement the SIOCSHWTSTAMP and SIOCGHWTSTAMP ioctl in
net_device_ops->ndo_eth_ioctl().

More details in:

  https://git.kernel.org/torvalds/c/90f942c5a6d7

The caveat is in the userland: the can-utils currently do not follow
the conventions. It does not send those ioctls and instead expects
hardware timestamps to be unconditionally always on.
But at least, it should work with tcpdump or any other generic packet
capture utilities which follow the kernel conventions.

(...)
