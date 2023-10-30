Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FFFA7DB91A
	for <lists+linux-can@lfdr.de>; Mon, 30 Oct 2023 12:38:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbjJ3Lin (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 30 Oct 2023 07:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjJ3Lim (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 30 Oct 2023 07:38:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 676B7A6;
        Mon, 30 Oct 2023 04:38:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 771B0C433C7;
        Mon, 30 Oct 2023 11:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698665920;
        bh=QsCOsifuCAFDbmtUWh5n7uOi046frmGhl3fvOSe7dzE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C3THIvgu+2aAf2Z69hO03yyHRC9KdXDTdBCntw7GsYuAKYm6SYIQ9WqPa87QdqTAL
         sYADALs3LcMHJw19Ebr8evB291Sf/qX80n4BapRkBO5jV6dX0PLu8gV5z7Y+4veVMB
         5hfnZ1wbfadRAtx+yrdxKV69Y3gtOO0XAjqoYwNA=
Date:   Mon, 30 Oct 2023 12:38:36 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     stable@vger.kernel.org, sashal@kernel.org,
        linux-can@vger.kernel.org, lukas.magel@posteo.net,
        patches@lists.linux.dev, maxime.jayat@mobile-devices.fr,
        mkl@pengutronix.de, michal.sojka@cvut.cz
Subject: Re: [PATCH] can: isotp: upgrade 5.15 LTS to latest 6.6 mainline code
 base
Message-ID: <2023103048-riverside-giving-e44d@gregkh>
References: <20231030113110.3404-1-socketcan@hartkopp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231030113110.3404-1-socketcan@hartkopp.net>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Mon, Oct 30, 2023 at 12:31:10PM +0100, Oliver Hartkopp wrote:
> The backport of commit 9c5df2f14ee3 ("can: isotp: isotp_ops: fix poll() to
> not report false EPOLLOUT events") introduced a new regression where the
> fix could potentially introduce new side effects.
> 
> To reduce the risk of other unmet dependencies and missing fixes and checks
> the latest mainline code base is ported back to the 5.15 LTS tree.
> 
> To meet the former Linux 5.15 API these commits have been reverted:
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

Please send these as individual patches, reverts and then the new ones
added, not as one huge commit that we can't review properly at all.

But why just 5.15?  What about 6.1.y and 6.5.y?

thanks,

greg k-h
