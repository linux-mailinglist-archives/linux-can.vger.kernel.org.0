Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8D37E1FDB
	for <lists+linux-can@lfdr.de>; Mon,  6 Nov 2023 12:23:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjKFLX4 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 6 Nov 2023 06:23:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbjKFLXz (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 6 Nov 2023 06:23:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 379DDC9;
        Mon,  6 Nov 2023 03:23:52 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77645C433C8;
        Mon,  6 Nov 2023 11:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699269831;
        bh=76fiMpxrGuLi7uw5LFNw/G11QnKqrlXPTRx6SDqrP2w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yKtL3GJIDlL+Mp61z1k+w0W5IB0QxgszdcaHN7fPLQfRPD2MZ95imOGgAtnjEs+ap
         VqBD9fXx/NQ3G26xihqyKxJPwsXKjQ1FGXOZNGI7nMTjv2UfGpGJPfgLBmed9eRDKF
         DBXducliFk3rw3uSXP3pHxCl0yLQ1jAWKCqmmvOU=
Date:   Mon, 6 Nov 2023 12:23:27 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     stable@vger.kernel.org, sashal@kernel.org,
        linux-can@vger.kernel.org, lukas.magel@posteo.net,
        patches@lists.linux.dev, maxime.jayat@mobile-devices.fr,
        mkl@pengutronix.de, michal.sojka@cvut.cz
Subject: Re: [PATCH stable 5.10 00/10] can: isotp: upgrade to latest 6.1 LTS
 code base
Message-ID: <2023110621-decaf-perfectly-4c88@gregkh>
References: <20231031092918.2668-1-socketcan@hartkopp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231031092918.2668-1-socketcan@hartkopp.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Tue, Oct 31, 2023 at 10:29:08AM +0100, Oliver Hartkopp wrote:
> The backport of commit 9c5df2f14ee3 ("can: isotp: isotp_ops: fix poll() to
> not report false EPOLLOUT events") introduced a new regression where the
> fix could potentially introduce new side effects.
> 
> To reduce the risk of other unmet dependencies and missing fixes and checks
> the latest 6.1 LTS code base is ported back to the 5.10 LTS tree.
> 
> Lukas Magel (1):
>   can: isotp: isotp_sendmsg(): fix TX state detection and wait behavior
> 
> Oliver Hartkopp (6):
>   can: isotp: set max PDU size to 64 kByte
>   can: isotp: isotp_bind(): return -EINVAL on incorrect CAN ID formatting
>   can: isotp: check CAN address family in isotp_bind()
>   can: isotp: handle wait_event_interruptible() return values
>   can: isotp: add local echo tx processing and tx without FC
>   can: isotp: isotp_bind(): do not validate unused address information
> 
> Patrick Menschel (3):
>   can: isotp: change error format from decimal to symbolic error names
>   can: isotp: add symbolic error message to isotp_module_init()
>   can: isotp: Add error message if txqueuelen is too small
> 
>  include/uapi/linux/can/isotp.h |  25 +-
>  net/can/isotp.c                | 434 +++++++++++++++++++++------------
>  2 files changed, 293 insertions(+), 166 deletions(-)
> 
> -- 
> 2.34.1
> 

Both series now queued up, thanks.

greg k-h
