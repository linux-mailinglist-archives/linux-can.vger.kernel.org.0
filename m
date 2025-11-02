Return-Path: <linux-can+bounces-5300-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C2E3C2982C
	for <lists+linux-can@lfdr.de>; Sun, 02 Nov 2025 23:11:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89AC5188B9A1
	for <lists+linux-can@lfdr.de>; Sun,  2 Nov 2025 22:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3782422422B;
	Sun,  2 Nov 2025 22:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kCsGyTWD"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CD821FF35
	for <linux-can@vger.kernel.org>; Sun,  2 Nov 2025 22:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762121472; cv=none; b=lE3L0vj69lSaCx4CWBeQYPXWfvr5fjOG4Jv3RUYLju7hr272dJQuy4s0dTuNLFFrToDe7rOq0MZmf1LhReF62JhgUlbijhC4S0Q8nNcxjlhMXnr0DYKzxL+TI843RdPzTtwAE4/QAlwPEe5v+LduQ1dpgyO/0dYeeDlFmFabw4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762121472; c=relaxed/simple;
	bh=Lhj4d+oaZWpT0lJDsPz3rtZwYgL9UXu/DLxLSO4F3nU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K1kbWsybSritCmA8AJIz3W8CqAPuzAaXGXMQEJv8O/HR3b81d6cb69tYaLH+mnOqvnsVwlkbP/2aG4cwEi2ugCfgSJf+zmcaFmRFuj+xeSRrSG9M3mGA2P4G7S6hN6SKi2VjXMK56LMpdYnPU81mQ5XLKAcydLZSdfIFXeakqU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kCsGyTWD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7273C4CEF7;
	Sun,  2 Nov 2025 22:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762121471;
	bh=Lhj4d+oaZWpT0lJDsPz3rtZwYgL9UXu/DLxLSO4F3nU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kCsGyTWDYIcvcNlZZKc5qVDEt1+zuCjHTJvDm9gHyTjOUpB5rGs/mMKTfms6TdJEE
	 YZmq1wk0V2jto9SqJymdjLi1OT9IXg/vWs2EvOVZq6uru4XOXUmQjZYKYJieGncoUb
	 oDyyyQz4i+4+p/Wy3GV/kDPvkeZ3wqAaDj1dUWlZ1j6H8c2JKt4GuZwWW3d0/LCY1h
	 7UyRLD8sEioqSdIcD5AchMbG07xMFcyLEltSYWBiRtVaU30I3rjftA0LIfpR0YZBo7
	 j5RKHZa6gJ3b7YzYPe5XbxPnI8+l/VSw9cM8WrmoaMDalLFzGwor9LHsdnbMH8sXhe
	 XjvqZ1p7VR62Q==
Message-ID: <69303466-a9ed-44cb-a1a9-30ac1451e7cb@kernel.org>
Date: Sun, 2 Nov 2025 23:11:07 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/10] can: netlink: add CAN XL
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Robert Nawrath <mbro1689@gmail.com>, Minh Le <minh.le.aj@renesas.com>,
 Duy Nguyen <duy.nguyen.rh@renesas.com>, linux-can@vger.kernel.org,
 Marc Kleine-Budde <mkl@pengutronix.de>,
 =?UTF-8?Q?St=C3=A9phane_Grosjean?= <stephane.grosjean@hms-networks.com>
References: <20251021-canxl-netlink-v2-0-8b8f58257ab6@kernel.org>
 <743ba133-3735-48fd-994a-9727cfe8c114@hartkopp.net>
Content-Language: en-US
From: Vincent Mailhol <mailhol@kernel.org>
Autocrypt: addr=mailhol@kernel.org; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 JFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbEBrZXJuZWwub3JnPsKZBBMWCgBBFiEE7Y9wBXTm
 fyDldOjiq1/riG27mcIFAmdfB/kCGwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcC
 F4AACgkQq1/riG27mcKBHgEAygbvORJOfMHGlq5lQhZkDnaUXbpZhxirxkAHwTypHr4A/joI
 2wLjgTCm5I2Z3zB8hqJu+OeFPXZFWGTuk0e2wT4JzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrb
 YZzu0JG5w8gxE6EtQe6LmxKMqP6EyR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDl
 dOjiq1/riG27mcIFAmceMvMCGwwFCQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8V
 zsZwr/S44HCzcz5+jkxnVVQ5LZ4BANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
In-Reply-To: <743ba133-3735-48fd-994a-9727cfe8c114@hartkopp.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Oliver,

Thanks for your feedback. Nice catches!

On 31/10/2025 at 22:17, Oliver Hartkopp wrote:
> Hi Vincent,
> 
> I managed to have my DE1SoC FPGA boards working including TMS after fixing a
> weird typo with the help from Bosch colleagues, the PCAN USB XL from Stephane
> (which worked as a correct node) and my scope.
> 
> First of all: The configuration and features are great any easy to use and give
> excellent feedback now.
> 
> Things that need to be changed:
> 
> 1. The xsample-point calculation follows the standard CiA sample-points:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/mailhol/linux.git/tree/drivers/
> net/can/dev/calc_bittiming.c?h=b4/canxl-netlink#n82
> 
>         /* Use CiA recommended sample points */
>         if (bt->sample_point) {
>                 sample_point_nominal = bt->sample_point;
>         } else {
>                 if (bt->bitrate > 800 * KILO /* BPS */)
>                         sample_point_nominal = 750;
>                 else if (bt->bitrate > 500 * KILO /* BPS */)
>                         sample_point_nominal = 800;
>                 else
>                         sample_point_nominal = 875;
>         }
> 
> But with "TMS on" the PWM method is used to transfer the bit-values.
> Therefore the sample-points are near to 50% - 60%, see Table 3 here:
> 
> https://www.can-cia.org/fileadmin/cia/documents/publications/cnlm/december_2024/
> cnlm_24-4_p18_can_xl_system_design_clock_tolerances_and_edge_deviations_dr_arthur_mutter_bosch.pdf
> 
> In my case I used ...
> 
> # ip link set can0 type can bitrate 1000000 sample-point 0.80 fd off xbitrate
> 10000000 xsample-point 0.57 xl on tms on err-signal off
> 
> ... to get the correct xsample-point 0.562:
> 
> # ip -det link show can0
> 11: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 2060 qdisc pfifo_fast state UP mode
> DEFAULT group default qlen 10
>     link/can  promiscuity 0 allmulti 0 minmtu 16 maxmtu 16
>     can <XL,XL-TMS> state STOPPED restart-ms 0
>       bitrate 1000000 sample-point 0.800
>       tq 6 prop-seg 63 phase-seg1 64 phase-seg2 32 sjw 16 brp 1
>       xcanb_can_nl: tseg1 2..512 tseg2 2..128 sjw 1..128 brp 1..32 brp_inc 1
>       xcanb_can_nl: dtseg1 1..256 dtseg2 2..128 dsjw 1..128 dbrp 1..32 dbrp_inc 1
>       tdco 0..255 tdcf 0..255
>       xbitrate 10000000 xsample-point 0.562
>       xtq 6 xprop-seg 4 xphase-seg1 4 xphase-seg2 7 xsjw 3 xbrp 1
>       pwms 4 pwml 12 pwmo 0
>       xcanb_can_nl: xtseg1 1..256 xtseg2 2..128 xsjw 1..128 xbrp 1..32 xbrp_inc 1
>       xtdco 0..255 xtdcf 0..255
>       pwms 1..8 pwml 2..24 pwmo 0..16
>       clock 160000000 addrgenmode eui64 numtxqueues 1 numrxqueues 1 gso_max_size
> 65536 gso_max_segs 65535 tso_max_size 65536 tso_max_segs 65535 gro_max_size
> 65536 gso_ipv4_max_size 65536 gro_ipv4_max_size 65536

I totally missed that. Thanks for raising this point! I just sent

https://lore.kernel.org/linux-can/20251102-pwm_sample_point-v1-0-3bbea180f59e@kernel.org/

to address the problem. Let me know if this works in your test environment and I
will merge it to the main series.

> 2. In the "xl on" "tms on" mode only CAN XL frames can be sent. So we need to
> drop CC and FD frames when they are sent, e.g. via CAN_RAW sockets.
> 
> Therefore
> 
> [PATCH v2 02/10] can: dev: can_dev_dropped_skb: drop CAN FD skbs if FD is off
> 
> has to be extended. And my proposed patch too:
> 
> [RFC PATCH v5 2/2] can: reject CAN FD content when disabled on CAN XL interfaces
> 
> https://lore.kernel.org/linux-can/20250909092433.30546-1-socketcan@hartkopp.net/
> T/#mcb0ebd94e45c34a2d0590ded2dfeed97edd05adf

Thanks for re-sending the patch! I remember we discussed this in September but
it somehow went out of my mind. I just have a quick look so far on the new patch
and so far it looks good. I will do a few more tests next week before adding it
to the XL main series.


Yours sincerely,
Vincent Mailhol


