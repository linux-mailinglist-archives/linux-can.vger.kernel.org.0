Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC0C5A4E03
	for <lists+linux-can@lfdr.de>; Mon, 29 Aug 2022 15:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbiH2N1P (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 29 Aug 2022 09:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiH2N0u (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 29 Aug 2022 09:26:50 -0400
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434054330D
        for <linux-can@vger.kernel.org>; Mon, 29 Aug 2022 06:25:15 -0700 (PDT)
Date:   Mon, 29 Aug 2022 13:25:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jbrengineering.co.uk; s=protonmail; t=1661779512; x=1662038712;
        bh=RhYZiH03edT/KWwIPn2yDHC/euMRR2e93a6Ai6zqnIs=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:Feedback-ID:From:To:Cc:Date:Subject:Reply-To:
         Feedback-ID:Message-ID;
        b=fZCpkN5eB84lshQ2ty8CnNOomkVWEzFO5dt+cEpSuPW59XcvTLQg6R5glKS3mXVph
         WjAdMEwf73PuSqq7WucKrPO88oll9tKRF69LriSQANND9/nLEEoS6wY3o6N94bApzw
         4kIcHAMKFRCrrK7Gj+6Qz6jdTqQ1XEzYbyGcCcMfs+mtY+SyJW9XjMb4VKR1IDAF1L
         QGoHI0fhu/qWOufUksMAmqfGZeclnh8uCE0x8rSiupFgxEPnMWrJG6z0KeoOioFuF2
         6wUoI/cB/s1lNj+PjzfbfQNgnmNaFc6ZR0lB7do7UDZsbkDxW2foFq2xsatScIDv13
         BUpXYSgvdgMPw==
To:     Marc Kleine-Budde <mkl@pengutronix.de>
From:   john@jbrengineering.co.uk
Cc:     linux-can@vger.kernel.org,
        John Whittington <git@jbrengineering.co.uk>
Reply-To: john@jbrengineering.co.uk
Subject: Re: [PATCH v3 0/2] can: gs_usb: hardware timestamp support
Message-ID: <MyXI-Jx_HXvD27BZVEPozG9rRz0c-D4T73FwD7ilsKm9Keh1iUCYzO5mSisRm6LWa74OUxp22EJnguo3jE7VmjHZpXnZPYs7Y7hEU6p6LZM=@jbrengineering.co.uk>
In-Reply-To: <20220827221548.3291393-1-mkl@pengutronix.de>
References: <20220827221548.3291393-1-mkl@pengutronix.de>
Feedback-ID: 45109726:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Marc,

Thanks for the support on this. I was following the threads but away so una=
ble to make changes. With the patch now squashed and your updates, it looks=
 like no further input is required from me on this.

Kind regards,
John.


------- Original Message -------
On Saturday, August 27th, 2022 at 23:15, Marc Kleine-Budde <mkl@pengutronix=
.de> wrote:


>
>
> Hello,
>
> after noticing that the gs_usb firmware sends timestamps on the TX,
> too, I updated the driver and squashed the 2nd patch. Also added
> proper endianness handling to gs_usb_get_timestamp(). I allowed to add
> myself as Co-developed-by.
>
> regards,
> Marc
>
> Changes since v2: https://lore.kernel.org/all/20220827092545.2971240-1-mk=
l@pengutronix.de
> - new patch 1/2: use common spelling of GS_USB in macros
> - squashed both old patches into now 2/2
> - use GS_USB instead of GSUSB in macros
> - gs_usb_get_timestamp(): renamed from gs_usb_get_sof_timestamp()
> - gs_usb_get_timestamp(): take care of endianness
> - gs_usb_skb_set_timestamp(): renamed from gs_usb_set_timestamp()
> - gs_usb_set_timestamp(): add new function to add timestamp to skb
> from struct gs_host_frame
> - add support for TX timestamps
> - gs_can_eth_ioctl(): return -EOPNOTSUPP if device doesn't support
> GS_CAN_FEATURE_HW_TIMESTAMP
> - gs_usb_get_ts_info(): renamed from gs_usb_get_ts_info_hwts()
> - gs_usb_get_ts_info(): call can_ethtool_op_get_ts_info_hwts() if
> device supports GS_CAN_FEATURE_HW_TIMESTAMP, call
> ethtool_op_get_ts_info() otherwise
>
> Changes since v1: https://lore.kernel.org/all/20220826104629.2837024-1-mk=
l@pengutronix.de
> - add new includes sorted
> - adjust multi line comment style
> - don't use 1e6, but 1 * HZ_PER_MHZ, to fix sparse warning
> - use __le32 instead of u32 in struct classic_can_ts and canfd_ts
> - place _ts in front of _quirk in union in struct gs_host_frame
> - gs_usb_get_sof_timestamp(): pass "const struct gs_can *dev" as 1st
> argument, not struct net_device *netdev, simplify return handling
> - gs_usb_timestamp_init(), gs_usb_timestamp_stop(),
> gs_usb_get_ts_info_hwts(): make static
> - gs_usb_timestamp_init(): increase cc->shift to maximize precision
>
> - fix long lines, remove braces {} for single statement blocks
> - gs_can_open(): move check for GS_CAN_FEATURE_HW_TIMESTAMP after all
> ctrlmode checks
> - gs_can_open(): move start polling sof timestamp after kfree(dm)
> - gs_can_close(): move stop polling sof timestamp to be symmetric with
> respect to gs_can_open()
> - gs_usb_probe(): make calculation of dev->hf_size_rx more robost
>
>
