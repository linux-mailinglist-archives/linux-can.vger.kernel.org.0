Return-Path: <linux-can+bounces-5556-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 68240C78270
	for <lists+linux-can@lfdr.de>; Fri, 21 Nov 2025 10:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 216CC31FE8
	for <lists+linux-can@lfdr.de>; Fri, 21 Nov 2025 09:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBFD433D6F6;
	Fri, 21 Nov 2025 09:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="OtkjPtgA";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="kemorO1/"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F7633C198
	for <linux-can@vger.kernel.org>; Fri, 21 Nov 2025 09:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763717130; cv=pass; b=fmYALAZK9Ev8bpgUJVctUuK7bfShra9NQpWJHp1YXX0sGzdbUL6WtbmnG9vPjDc2dP3phEwM5A6sjvNSR2TNlq15VfMnN5MT93u/N/DUWM2sAuU71KFxBT9mtUBHnrpaAuhPwQ2jGrGctV4i8rURZLeekqJdMYC770iDXSyEBWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763717130; c=relaxed/simple;
	bh=HRvKP8a1oY8w87Y7NKSOKvrwE4DprfDa3kY1zFd9CUU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SbWaKYo8PeT2Rh2IKPA51UAuRFb+m5iPCg9OLaHBB/5D3M+CcmnoVgAKP9WJ2VI5Dioqo9mgc94fW9YrgLhTws1qaFbgD2aku2mQlcKE7yXwxLKMsTfcLh5W53IF91RxyEq5WLUyntDKwMo3mf0Y+ICXvN3DDWYGlQ6KV2wJgTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=OtkjPtgA; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=kemorO1/; arc=pass smtp.client-ip=81.169.146.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1763717122; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ld+pIkOrMZ/j03wmqzLaxr9VY/1jM963svYd+JaxSmWIxXMsONCKfHVrh9CJH+svIS
    wSbaQ1Ya4dtdFLDVEDKmE6sy+Wgyr0qeGZv+mqL/ymIudUydyG5r+zOQOvinr+4T5b5Z
    UfgLPsllDLckVuUgbanfNQsKA6y+Kf/3Ci+yNRv7vQ14D05NH2uofQNa2A3sOS3eFurI
    bzPY8ApGx4U/qZkpt+F+eNNjAME+YsNdOpVhW6gOBzfZpEM0h09XySqg0G47FPZbmDsl
    oMTZhjTpB9l1jQ3QibGjRchq1+0TSOJVUbx1CKxDgXXGo2td+0ODdgHVD9OP3Nf+JB84
    BNaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1763717122;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=tJjv+6i3Zpk2Pl4Ls/EOnN0C8ZleIWyfOu5unavCQr0=;
    b=YKEFoCuJwfkQo3erLVsUfKuwsx9IdmeBJNJz8utdvRH9jVKdskh7AbC7WyPldLUGBa
    EoeV4wwjoTNU3zrmjVaJ5gxVSkGFxlmMzBVNYEimWiCtx0aeSNQaP9eiMq3ooGBz3p+C
    9G/pYo7+5he7QkO7xJfinbqcBXhxVKo0cBsKUfj9s6K0QO9rDbH1ZDGZNOEmq6MP4R8S
    oTud3B9VOiDTf2muxNTJe6pgPM62XVAKEK9v9mjm1BnAvp5VYvyyxtkbelGLi82BynBz
    KMy+PAaGYCxEWn6RFOtMuzHQwYuhNrSrMqUPCRVfXjiq0FW76i0H8bjy92U2bP/nwoqZ
    a/Bw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1763717122;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=tJjv+6i3Zpk2Pl4Ls/EOnN0C8ZleIWyfOu5unavCQr0=;
    b=OtkjPtgAwK21bRs8fvDpadBnBFfO6fvWH/PSGRqzl1qqS1bt9kGFcoTarBx0YjPjuu
    pRZ40decgt0PfANzgYjuFnKSydolH0V9IZ3HrGXpn91objq3Heglv/C+8uW34MugvyTT
    4tLhdlJP2o/mT+DrGhd+FCZSAdXNCuLGw5POOqvx1QpoUMbBQTv4TdSC+nnyNkeXOiVw
    F+PE+XOALMfiiu9toQvZzsgqEnrKQAUzeS8rXnqzhAQMPZczs/dKDaOxpDslzb8dpPBm
    idz1wWI3s/0n4jUu3/xTpheRyXUmmsMPKEOkXV105lkMsl6PsFI9czmTVDTfdLvtt3LA
    zQ2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1763717122;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=tJjv+6i3Zpk2Pl4Ls/EOnN0C8ZleIWyfOu5unavCQr0=;
    b=kemorO1/yRSyBuV6/aJslL3fqp3VscG53VXJViam4cZFIpNMPJITf7emb+wcIR44SG
    C39xR8q2XqTgWbjOVKCg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::9f3]
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461AL9PMAxZ
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 21 Nov 2025 10:25:22 +0100 (CET)
Message-ID: <8f92e327-2751-473d-905e-246beac0d634@hartkopp.net>
Date: Fri, 21 Nov 2025 10:25:21 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [canxl v4 14/17] can: add dummy_can driver
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, Vincent Mailhol <mailhol@kernel.org>
References: <20251121083414.3642-1-socketcan@hartkopp.net>
 <20251121083414.3642-15-socketcan@hartkopp.net>
 <20251121-bald-encouraging-jaguarundi-6688a4-mkl@pengutronix.de>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20251121-bald-encouraging-jaguarundi-6688a4-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 21.11.25 10:21, Marc Kleine-Budde wrote:
> On 21.11.2025 09:34:11, Oliver Hartkopp wrote:
>> From: Vincent Mailhol <mailhol@kernel.org>
>>
>> During the development of CAN XL, we found the need of creating a
>> dummy CAN XL driver in order to test the new netlink interface. While
>> this code was initially intended to be some throwaway, it received
>> some positive feedback.
>>
>> Add the dummy_can driver. This driver acts similarly to the vcan
>> interface in the sense that it will echo back any packet it receives.
>> The difference is that it exposes a set on bittiming parameters as a
>> real device would and thus must be configured as if it was a real
>> physical interface.
>>
>> The driver comes with a debug mode. If debug message are enabled (for
>> example by enabling CONFIG_CAN_DEBUG_DEVICES), it will print in the
>> kernel log all the bittiming values, similar to what a:
>>
>>    ip --details link show can0
>>
>> would do.
>>
>> This driver is mostly intended for debugging and testing, but some
>> developers also may want to look at it as a simple reference
>> implementation.
>>
>> Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
>> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
>> ---
>>   drivers/net/can/Kconfig     |  17 +++
>>   drivers/net/can/Makefile    |   1 +
>>   drivers/net/can/dummy_can.c | 284 ++++++++++++++++++++++++++++++++++++
>>   3 files changed, 302 insertions(+)
>>   create mode 100644 drivers/net/can/dummy_can.c
>>
>> diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
>> index d43d56694667..e15e320db476 100644
>> --- a/drivers/net/can/Kconfig
>> +++ b/drivers/net/can/Kconfig
>> @@ -122,10 +122,27 @@ config CAN_CAN327
>>   	  Please refer to the documentation for information on how to use it:
>>   	  Documentation/networking/device_drivers/can/can327.rst
>>
>>   	  If this driver is built as a module, it will be called can327.
>>
>> +config CAN_DUMMY
>> +	tristate "Dummy CAN"
>> +	help
>> +	  A dummy CAN module supporting Classical CAN, CAN FD and CAN XL. It
>> +	  exposes bittiming values which can be configured through the netlink
>> +	  interface.
>> +
>> +	  The module will simply echo any frame sent to it. If debug messages
>> +	  are activated, it prints all the CAN bittiming information in the
>> +	  kernel log. Aside from that it does nothing.
>> +
>> +	  This is convenient for testing the CAN netlink interface. Most of the
>> +	  users will never need this. If unsure, say NO.
>> +
>> +	  To compile this driver as a module, choose M here: the module will be
>> +	  called dummy-can.
>> +
>>   config CAN_FLEXCAN
>>   	tristate "Support for Freescale FLEXCAN based chips"
>>   	depends on OF || COLDFIRE || COMPILE_TEST
>>   	depends on HAS_IOMEM
>>   	select CAN_RX_OFFLOAD
>> diff --git a/drivers/net/can/Makefile b/drivers/net/can/Makefile
>> index 56138d8ddfd2..d7bc10a6b8ea 100644
>> --- a/drivers/net/can/Makefile
>> +++ b/drivers/net/can/Makefile
>> @@ -19,10 +19,11 @@ obj-$(CONFIG_CAN_AT91)		+= at91_can.o
>>   obj-$(CONFIG_CAN_BXCAN)		+= bxcan.o
>>   obj-$(CONFIG_CAN_CAN327)	+= can327.o
>>   obj-$(CONFIG_CAN_CC770)		+= cc770/
>>   obj-$(CONFIG_CAN_C_CAN)		+= c_can/
>>   obj-$(CONFIG_CAN_CTUCANFD)	+= ctucanfd/
>> +obj-$(CONFIG_CAN_DUMMY)		+= dummy_can.o
>>   obj-$(CONFIG_CAN_FLEXCAN)	+= flexcan/
>>   obj-$(CONFIG_CAN_GRCAN)		+= grcan.o
>>   obj-$(CONFIG_CAN_IFI_CANFD)	+= ifi_canfd/
>>   obj-$(CONFIG_CAN_JANZ_ICAN3)	+= janz-ican3.o
>>   obj-$(CONFIG_CAN_KVASER_PCIEFD)	+= kvaser_pciefd/
>> diff --git a/drivers/net/can/dummy_can.c b/drivers/net/can/dummy_can.c
>> new file mode 100644
>> index 000000000000..97af0847db00
>> --- /dev/null
>> +++ b/drivers/net/can/dummy_can.c
>> @@ -0,0 +1,284 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +/* Copyright (c) 2025 Vincent Mailhol <mailhol@kernel.org> */
>> +
>> +#include <linux/array_size.h>
>> +#include <linux/errno.h>
>> +#include <linux/init.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/netdevice.h>
>> +#include <linux/units.h>
>> +
>> +#include <linux/can.h>
>> +#include <linux/can/bittiming.h>
>> +#include <linux/can/dev.h>
>> +#include <linux/can/skb.h>
>> +
>> +struct dummy_can {
>> +	struct can_priv can;
>> +	struct net_device *dev;
>> +};
>> +
>> +static struct dummy_can *dummy_can;
>> +
>> +static const struct can_bittiming_const dummy_can_bittiming_const = {
>> +	.name = "dummy_can CC",
>> +	.tseg1_min = 2,
>> +	.tseg1_max = 256,
>> +	.tseg2_min = 2,
>> +	.tseg2_max = 128,
>> +	.sjw_max = 128,
>> +	.brp_min = 1,
>> +	.brp_max = 512,
>> +	.brp_inc = 1
>> +};
>> +
>> +static const struct can_bittiming_const dummy_can_fd_databittiming_const = {
>> +	.name = "dummy_can FD",
>> +	.tseg1_min = 2,
>> +	.tseg1_max = 256,
>> +	.tseg2_min = 2,
>> +	.tseg2_max = 128,
>> +	.sjw_max = 128,
>> +	.brp_min = 1,
>> +	.brp_max = 512,
>> +	.brp_inc = 1
>> +};
>> +
>> +static const struct can_tdc_const dummy_can_fd_tdc_const = {
>> +	.tdcv_min = 0,
>> +	.tdcv_max = 0, /* Manual mode not supported. */
>> +	.tdco_min = 0,
>> +	.tdco_max = 127,
>> +	.tdcf_min = 0,
>> +	.tdcf_max = 127
>> +};
>> +
>> +static const struct can_bittiming_const dummy_can_xl_databittiming_const = {
>> +	.name = "dummy_can XL",
>> +	.tseg1_min = 2,
>> +	.tseg1_max = 256,
>> +	.tseg2_min = 2,
>> +	.tseg2_max = 128,
>> +	.sjw_max = 128,
>> +	.brp_min = 1,
>> +	.brp_max = 512,
>> +	.brp_inc = 1
>> +};
>> +
>> +static const struct can_tdc_const dummy_can_xl_tdc_const = {
>> +	.tdcv_min = 0,
>> +	.tdcv_max = 0, /* Manual mode not supported. */
>> +	.tdco_min = 0,
>> +	.tdco_max = 127,
>> +	.tdcf_min = 0,
>> +	.tdcf_max = 127
>> +};
>> +
>> +static const struct can_pwm_const dummy_can_pwm_const = {
>> +	.pwms_min = 1,
>> +	.pwms_max = 8,
>> +	.pwml_min = 2,
>> +	.pwml_max = 24,
>> +	.pwmo_min = 0,
>> +	.pwmo_max = 16,
>> +};
>> +
>> +static void dummy_can_print_bittiming(struct net_device *dev,
>> +				      struct can_bittiming *bt)
>> +{
>> +	netdev_dbg(dev, "\tbitrate: %u\n", bt->bitrate);
>> +	netdev_dbg(dev, "\tsample_point: %u\n", bt->sample_point);
>> +	netdev_dbg(dev, "\ttq: %u\n", bt->tq);
>> +	netdev_dbg(dev, "\tprop_seg: %u\n", bt->prop_seg);
>> +	netdev_dbg(dev, "\tphase_seg1: %u\n", bt->phase_seg1);
>> +	netdev_dbg(dev, "\tphase_seg2: %u\n", bt->phase_seg2);
>> +	netdev_dbg(dev, "\tsjw: %u\n", bt->sjw);
>> +	netdev_dbg(dev, "\tbrp: %u\n", bt->brp);
>> +}
>> +
>> +static void dummy_can_print_tdc(struct net_device *dev, struct can_tdc *tdc)
>> +{
>> +	netdev_dbg(dev, "\t\ttdcv: %u\n", tdc->tdcv);
>> +	netdev_dbg(dev, "\t\ttdco: %u\n", tdc->tdco);
>> +	netdev_dbg(dev, "\t\ttdcf: %u\n", tdc->tdcf);
>> +}
>> +
>> +static void dummy_can_print_pwm(struct net_device *dev, struct can_pwm *pwm,
>> +				struct can_bittiming *dbt)
>> +{
>> +	netdev_dbg(dev, "\t\tpwms: %u\n", pwm->pwms);
>> +	netdev_dbg(dev, "\t\tpwml: %u\n", pwm->pwml);
>> +	netdev_dbg(dev, "\t\tpwmo: %u\n", pwm->pwmo);
>> +}
>> +
>> +static void dummy_can_print_ctrlmode(struct net_device *dev)
>> +{
>> +	struct dummy_can *priv = netdev_priv(dev);
>> +	struct can_priv *can_priv = &priv->can;
>> +	unsigned long supported = can_priv->ctrlmode_supported;
>> +	u32 enabled = can_priv->ctrlmode;
>> +
>> +	netdev_dbg(dev, "Control modes:\n");
>> +	netdev_dbg(dev, "\tsupported: 0x%08x\n", (u32)supported);
>> +	netdev_dbg(dev, "\tenabled: 0x%08x\n", enabled);
>> +
>> +	if (supported) {
>> +		int idx;
>> +
>> +		netdev_dbg(dev, "\tlist:");
>> +		for_each_set_bit(idx, &supported, BITS_PER_TYPE(u32))
>> +			netdev_dbg(dev, "\t\t%s: %s\n",
>> +				   can_get_ctrlmode_str(BIT(idx)),
>> +				   enabled & BIT(idx) ? "on" : "off");
>> +	}
>> +}
>> +
>> +static void dummy_can_print_bittiming_info(struct net_device *dev)
>> +{
>> +	struct dummy_can *priv = netdev_priv(dev);
>> +	struct can_priv *can_priv = &priv->can;
>> +
>> +	netdev_dbg(dev, "Clock frequency: %u\n", can_priv->clock.freq);
>> +	netdev_dbg(dev, "Maximum bitrate: %u\n", can_priv->bitrate_max);
>> +	netdev_dbg(dev, "MTU: %u\n", dev->mtu);
>> +	netdev_dbg(dev, "\n");
>> +
>> +	dummy_can_print_ctrlmode(dev);
>> +	netdev_dbg(dev, "\n");
>> +
>> +	netdev_dbg(dev, "Classical CAN nominal bittiming:\n");
>> +	dummy_can_print_bittiming(dev, &can_priv->bittiming);
>> +	netdev_dbg(dev, "\n");
>> +
>> +	if (can_priv->ctrlmode & CAN_CTRLMODE_FD) {
>> +		netdev_dbg(dev, "CAN FD databittiming:\n");
>> +		dummy_can_print_bittiming(dev, &can_priv->fd.data_bittiming);
>> +		if (can_fd_tdc_is_enabled(can_priv)) {
>> +			netdev_dbg(dev, "\tCAN FD TDC:\n");
>> +			dummy_can_print_tdc(dev, &can_priv->fd.tdc);
>> +		}
>> +	}
>> +	netdev_dbg(dev, "\n");
>> +
>> +	if (can_priv->ctrlmode & CAN_CTRLMODE_XL) {
>> +		netdev_dbg(dev, "CAN XL databittiming:\n");
>> +		dummy_can_print_bittiming(dev, &can_priv->xl.data_bittiming);
>> +		if (can_xl_tdc_is_enabled(can_priv)) {
>> +			netdev_dbg(dev, "\tCAN XL TDC:\n");
>> +			dummy_can_print_tdc(dev, &can_priv->xl.tdc);
>> +		}
>> +		if (can_priv->ctrlmode & CAN_CTRLMODE_XL_TMS) {
>> +			netdev_dbg(dev, "\tCAN XL PWM:\n");
>> +			dummy_can_print_pwm(dev, &can_priv->xl.pwm,
>> +					    &can_priv->xl.data_bittiming);
>> +		}
>> +	}
>> +	netdev_dbg(dev, "\n");
>> +}
>> +
>> +static int dummy_can_netdev_open(struct net_device *dev)
>> +{
>> +	int ret;
>> +	struct can_priv *priv = netdev_priv(dev);
>> +
>> +	dummy_can_print_bittiming_info(dev);
>> +	netdev_dbg(dev, "error-signalling is %sabled\n",
>> +		   can_dev_in_xl_only_mode(priv)?"dis":"en");
> 
> please make use of string_choices.h

Ok. I'll take a look at it.

Best regards,
Oliver

