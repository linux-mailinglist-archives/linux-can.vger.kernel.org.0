Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C608C7DB91F
	for <lists+linux-can@lfdr.de>; Mon, 30 Oct 2023 12:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233073AbjJ3LjV (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 30 Oct 2023 07:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233070AbjJ3LjT (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 30 Oct 2023 07:39:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D3A8C4;
        Mon, 30 Oct 2023 04:39:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34F0FC433C8;
        Mon, 30 Oct 2023 11:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698665956;
        bh=8Wq9ocScwXCiYyTROzBfrzKGUq2KycdYEvF7lpZwvhQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m+sQRnkwiEGDB8gMMWDes5ow/E7mtSAsiqFF5phrd1S0m2BRl5+Cc68YEfITuOPQw
         vgB8sONeLnoQg2VTaLI3umvGGjdvczB7mBB+nSzNWZ921RaMV1huO7HO4n7vElVT3Q
         vRRELPKtqTjjdsHwftVZgCHC8NqL8dk23JPttNyk=
Date:   Mon, 30 Oct 2023 12:39:13 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     stable@vger.kernel.org, sashal@kernel.org,
        linux-can@vger.kernel.org, lukas.magel@posteo.net,
        patches@lists.linux.dev, maxime.jayat@mobile-devices.fr,
        mkl@pengutronix.de, michal.sojka@cvut.cz
Subject: Re: [PATCH] can: isotp: upgrade 5.10 LTS to latest 6.6 mainline code
 base
Message-ID: <2023103002-squiggly-handrail-09ba@gregkh>
References: <20231030113027.3387-1-socketcan@hartkopp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231030113027.3387-1-socketcan@hartkopp.net>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Mon, Oct 30, 2023 at 12:30:27PM +0100, Oliver Hartkopp wrote:
> The backport of commit 9c5df2f14ee3 ("can: isotp: isotp_ops: fix poll() to
> not report false EPOLLOUT events") introduced a new regression where the
> fix could potentially introduce new side effects.
> 
> To reduce the risk of other unmet dependencies and missing fixes and checks
> the latest mainline code base is ported back to the 5.10 LTS tree.
> 
> To meet the former Linux 5.10 API these commits have been reverted:
> e3ae2365efc1 ("net: sock: introduce sk_error_report")
> f4b41f062c42 ("net: remove noblock parameter from skb_recv_datagram()")
> 96a7457a14d9 ("can: skb: unify skb CAN frame identification helpers")
> dc97391e6610 ("sock: Remove ->sendpage*() in favour of sendmsg(MSG_SPLICE_PAGES)")
> 0145462fc802 ("can: isotp: isotp_recvmsg(): use sock_recv_cmsgs() to get SOCK_RXQ_OVFL infos")
> 
> New features and communication stability measures:
> 9f39d36530e5 ("can: isotp: add support for transmission without flow control")
> 96d1c81e6a04 ("can: isotp: add module parameter for maximum pdu size")
> 4b7fe92c0690 ("can: isotp: add local echo tx processing for consecutive frames")
> 530e0d46c613 ("can: isotp: set default value for N_As to 50 micro seconds")
> 
> And various sanity checks, fixes and improved return values.
> 
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> ---
>  include/uapi/linux/can/isotp.h |  25 +-
>  net/can/isotp.c                | 495 ++++++++++++++++++++++-----------
>  2 files changed, 347 insertions(+), 173 deletions(-)

Same here, sorry, we need the individual commits.

greg k-h
