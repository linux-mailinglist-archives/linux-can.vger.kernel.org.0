Return-Path: <linux-can+bounces-5292-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A482C27049
	for <lists+linux-can@lfdr.de>; Fri, 31 Oct 2025 22:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 021ED4E6454
	for <lists+linux-can@lfdr.de>; Fri, 31 Oct 2025 21:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D1E301482;
	Fri, 31 Oct 2025 21:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="pQo3KuuU"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43A927280B
	for <linux-can@vger.kernel.org>; Fri, 31 Oct 2025 21:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.164
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761945835; cv=pass; b=i/fSFMfomzsnY7B/E2fOuw7lCKenM3pLNpYQZJNyXLzZooWgbHE8GLjPr8yNicXED/x2huG35CgIKow8iO4UG9aPcDqGtm9uBzZVZh2ucC5AdvNZ8pH6HhmUMS2ta+O67j3qia6+KGFiFMaEFKuJLwVid6Ie3hxmDRvpGDOgMaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761945835; c=relaxed/simple;
	bh=3jPuaMrhWx9SOM4t9C4H2/fUVpCtKDKYbJ4/Qa4LKPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tobkiwnYvKF01d9+Mkoy059/H/UuzmH3iqU5M0KVjCbrIchEnndAo9EReMeeAGtQ1Ww4k0EsUMHXVQgUGXy6dTUpFqU5GBX/Fw0/+Qq4yrZ9DoOm+gtUvaCBXilZdJ+Ns5hqPHDGFl9pcV0SpbAZQagesF6wZzyFT1OCKPg098M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=pQo3KuuU; arc=pass smtp.client-ip=81.169.146.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1761945464; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=J9vX1zcZScDvr6GXZ5E7q2BydqkdZ0J2lhNF5BUIKDgORcD98dGo8ptsupt82l2t/B
    amGfUuhQrlYRZZBHAqfZxtiiOe87tfNDAJJmkkdTEy+TybDHtzsTO0y0ygAnDrSHCwXE
    zZHoR6/nrPdlCfue0sZe0XVg1ui47xPCam/TeKcGcgR/9WcD3aueM5Qztp63n5BEdf/4
    Q8wbt5xnqeyGKxoNw4OMmyBZDMmAl/w9NeTDvO8yIc9a51majb2oMbEMAPwh/DPy70No
    T+zfdvZOd6L4Wjye7T7ZoXkl51Dg7zyVzTR7xEyugRlF2oTh05NA/i3K/DS+jr4CKIiA
    kjXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1761945464;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=u9jf4jJVbH2HwGmlQHqFyWMPOspKXIvKCXTZW435rkA=;
    b=imBUhdIHWBwaub87UngnuJGHtxR3BY4bY0Dbma7yriN0mGveBVwaRalrRjxk1RgAIa
    bE/yOJsI2a27jZ4EefeGd8cG+2nvcR58MmH5ivqLXOSFBfkwHgP2AzP0BQvnD2k06iMD
    bhga+tB87YikmNDmb5/JbMdVkF4lRyxClkwFWgaT2NCE1fTQOYoGEqpsz3atgQeEmmkI
    QwF30qxupJpTaLPivmeDswI8tpoUFgAvMV+OuH7WLCOcKKyNJFaUizGYz9nCcAOKVFAy
    hiHkTNnqa6xvWwstkCjluimlP63DYpaT7dnSWQpB5RkzmU0yvwaxo67/nYW5GL70P6+n
    e3GQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1761945464;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=u9jf4jJVbH2HwGmlQHqFyWMPOspKXIvKCXTZW435rkA=;
    b=pQo3KuuUuZYP2kbNRvvGTojCncWlm3KijwD8CrAMZE11OT3z3x84bGi7yADVTAEupp
    EmjfPYV/KFpW15rb3+u8P5tyZwOFlLF2Ljxucn0Wp/enVqpQy3O7NRc1QkxX1vRbHIUc
    K23YaVnvkp4aFHXL8n306uxyZGbsCVlZ9AEexQ+NwYnsPfOgcYKkEnOKKH7VocSYLNdP
    MGHM5myXVNnqRajx/Yq+qaEvi8DApLKkYI1F7wD7aoopnF1Epsq4w3nmXWTlyhjZKZ4w
    R8ifPs/rGPbeCbeiHFaH3R4LQmM5nxr+zRP61GNZGXarHnXBkjBn2KYgxwDYGgDj+fDY
    NhNA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::9f3]
    by smtp.strato.de (RZmta 53.4.2 AUTH)
    with ESMTPSA id Kf23d019VLHhs7r
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 31 Oct 2025 22:17:43 +0100 (CET)
Message-ID: <743ba133-3735-48fd-994a-9727cfe8c114@hartkopp.net>
Date: Fri, 31 Oct 2025 22:17:36 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/10] can: netlink: add CAN XL
To: Vincent Mailhol <mailhol@kernel.org>,
 Marc Kleine-Budde <mkl@pengutronix.de>,
 =?UTF-8?Q?St=C3=A9phane_Grosjean?= <stephane.grosjean@hms-networks.com>
Cc: Robert Nawrath <mbro1689@gmail.com>, Minh Le <minh.le.aj@renesas.com>,
 Duy Nguyen <duy.nguyen.rh@renesas.com>, linux-can@vger.kernel.org
References: <20251021-canxl-netlink-v2-0-8b8f58257ab6@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20251021-canxl-netlink-v2-0-8b8f58257ab6@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Vincent,

I managed to have my DE1SoC FPGA boards working including TMS after 
fixing a weird typo with the help from Bosch colleagues, the PCAN USB XL 
from Stephane (which worked as a correct node) and my scope.

First of all: The configuration and features are great any easy to use 
and give excellent feedback now.

Things that need to be changed:

1. The xsample-point calculation follows the standard CiA sample-points:

https://git.kernel.org/pub/scm/linux/kernel/git/mailhol/linux.git/tree/drivers/net/can/dev/calc_bittiming.c?h=b4/canxl-netlink#n82

         /* Use CiA recommended sample points */
         if (bt->sample_point) {
                 sample_point_nominal = bt->sample_point;
         } else {
                 if (bt->bitrate > 800 * KILO /* BPS */)
                         sample_point_nominal = 750;
                 else if (bt->bitrate > 500 * KILO /* BPS */)
                         sample_point_nominal = 800;
                 else
                         sample_point_nominal = 875;
         }

But with "TMS on" the PWM method is used to transfer the bit-values.
Therefore the sample-points are near to 50% - 60%, see Table 3 here:

https://www.can-cia.org/fileadmin/cia/documents/publications/cnlm/december_2024/cnlm_24-4_p18_can_xl_system_design_clock_tolerances_and_edge_deviations_dr_arthur_mutter_bosch.pdf

In my case I used ...

# ip link set can0 type can bitrate 1000000 sample-point 0.80 fd off 
xbitrate 10000000 xsample-point 0.57 xl on tms on err-signal off

... to get the correct xsample-point 0.562:

# ip -det link show can0
11: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 2060 qdisc pfifo_fast state UP 
mode DEFAULT group default qlen 10
     link/can  promiscuity 0 allmulti 0 minmtu 16 maxmtu 16
     can <XL,XL-TMS> state STOPPED restart-ms 0
	  bitrate 1000000 sample-point 0.800
	  tq 6 prop-seg 63 phase-seg1 64 phase-seg2 32 sjw 16 brp 1
	  xcanb_can_nl: tseg1 2..512 tseg2 2..128 sjw 1..128 brp 1..32 brp_inc 1
	  xcanb_can_nl: dtseg1 1..256 dtseg2 2..128 dsjw 1..128 dbrp 1..32 
dbrp_inc 1
	  tdco 0..255 tdcf 0..255
	  xbitrate 10000000 xsample-point 0.562
	  xtq 6 xprop-seg 4 xphase-seg1 4 xphase-seg2 7 xsjw 3 xbrp 1
	  pwms 4 pwml 12 pwmo 0
	  xcanb_can_nl: xtseg1 1..256 xtseg2 2..128 xsjw 1..128 xbrp 1..32 
xbrp_inc 1
	  xtdco 0..255 xtdcf 0..255
	  pwms 1..8 pwml 2..24 pwmo 0..16
	  clock 160000000 addrgenmode eui64 numtxqueues 1 numrxqueues 1 
gso_max_size 65536 gso_max_segs 65535 tso_max_size 65536 tso_max_segs 
65535 gro_max_size 65536 gso_ipv4_max_size 65536 gro_ipv4_max_size 65536


2. In the "xl on" "tms on" mode only CAN XL frames can be sent. So we 
need to drop CC and FD frames when they are sent, e.g. via CAN_RAW sockets.

Therefore

[PATCH v2 02/10] can: dev: can_dev_dropped_skb: drop CAN FD skbs if FD 
is off

has to be extended. And my proposed patch too:

[RFC PATCH v5 2/2] can: reject CAN FD content when disabled on CAN XL 
interfaces

https://lore.kernel.org/linux-can/20250909092433.30546-1-socketcan@hartkopp.net/T/#mcb0ebd94e45c34a2d0590ded2dfeed97edd05adf

I'll continue testing next week.

Best regards,
Oliver

On 21.10.25 17:47, Vincent Mailhol wrote:
> Following all the refactoring on the CAN netlink done in series [1],
> [2] and [3], this is now time to finally introduce the CAN XL netlink
> interface.
> 
> Similarly to how CAN FD reuses the bittiming logic of Classical CAN,
> CAN XL also reuses the entirety of CAN FD features, and, on top of
> that, adds new features which are specific to CAN XL.
> 
> Patch #1 is a small clean-up which makes can_calc_bittiming() use
> NL_SET_ERR_MSG() instead of netdev_err().
> 
> Patch #2 adds a check in can_dev_dropped_skb() to drop CAN FD frames
> when CAN FD is turned off.
> 
> Patch #3 adds CAN_CTRLMODE_RESTRICTED. Note that contrary to the other
> CAN_CTRL_MODE_XL_* that are introduced in the later patches, this
> control mode is not specific to CAN XL. The nuance is that because
> this restricted mode was only added in ISO 11898-1:2024, it is made
> mandatory for CAN XL devices but optional for other protocols. This is
> why this patch is added as a preparation before introducing the core
> CAN XL logic.
> 
> Patch #4 adds all the CAN XL features which are inherited from CAN FD:
> the nominal bittiming, the data bittiming and the TDC.
> 
> Patch #5 and #6 add two new CAN control modes which are specific to
> CAN XL: CAN_CTRLMODE_XL_TMS, CAN_CTRLMODE_XL_ERR_SIGNAL respectively.
> 
> Finally, patch #7 to #10 add the PWM logic.
> 
> [1] can: netlink: preparation before introduction of CAN XL
> Link: https://lore.kernel.org/linux-can/20241112165118.586613-7-mailhol.vincent@wanadoo.fr/
> 
> [2] can: rework the CAN MTU logic (CAN XL preparation step 2/3)
> Link: https://lore.kernel.org/linux-can/20250923-can-fix-mtu-v3-0-581bde113f52@kernel.org/
> 
> [3] can: netlink: preparation before introduction of CAN XL step 3/3
> Link: https://lore.kernel.org/linux-can/20250923-canxl-netlink-prep-v4-0-e720d28f66fe@kernel.org/
> 
> ---
> Changes in v2:
> 
>    - Add a new patch #1.
> 
>    - In patch #9, add a return statement to can_calc_tdco() when
>      CONFIG_CAN_CALC_BITTIMING is not set. This fixes a warning as
>      reported by the kernel test robot:
> 
>        Link: https://lore.kernel.org/linux-can/202510140553.qo3f0I9s-lkp@intel.com/
> 
>      While at it, add an error message.
> 
> Link to v1: https://lore.kernel.org/r/20251013-canxl-netlink-v1-0-f422b7e2729f@kernel.org
> 
> Changes in v1:
> 
>     - Add PWM
> 
>     - Add the CAN_CTRLMODE_RESTRICTED, CAN_CTRLMODE_XL_TMS and
>       CAN_CTRLMODE_XL_ERR_SIGNAL control modes.
> 
>     - A lot has changed since the original RFC was sent in November
>       last year.  The preparation patches went in a separate series as
>       explained in the cover letter, and what used to be a single patch
>       to introduce CAN XL is now a full series. A few additional
>       details are added to the individual patches, but overall I did
>       not keep track of all the changes over the last year. You may as
>       well consider this as a new series.
>     
> Link to RFC: https://lore.kernel.org/linux-can/20241110155902.72807-16-mailhol.vincent@wanadoo.fr/
> 
> ---
> Vincent Mailhol (10):
>        can: bittiming: apply NL_SET_ERR_MSG() to can_calc_bittiming()
>        can: dev: can_dev_dropped_skb: drop CAN FD skbs if FD is off
>        can: netlink: add CAN_CTRLMODE_RESTRICTED
>        can: netlink: add initial CAN XL support
>        can: netlink: add CAN_CTRLMODE_XL_TMS flag
>        can: netlink: add CAN_CTRLMODE_XL_ERR_SIGNAL
>        can: bittiming: add PWM parameters
>        can: bittiming: add PWM validation
>        can: calc_bittiming: add PWM calculation
>        can: netlink: add PWM netlink interface
> 
>   drivers/net/can/dev/bittiming.c      |  63 +++++++
>   drivers/net/can/dev/calc_bittiming.c |  36 ++++
>   drivers/net/can/dev/dev.c            |  20 +-
>   drivers/net/can/dev/netlink.c        | 357 +++++++++++++++++++++++++++++++++--
>   include/linux/can/bittiming.h        |  81 +++++++-
>   include/linux/can/dev.h              |  49 +++--
>   include/uapi/linux/can/netlink.h     |  35 ++++
>   7 files changed, 599 insertions(+), 42 deletions(-)
> ---
> base-commit: ffee675aceb9f44b0502a8bec912abb0c4f4af62
> change-id: 20241229-canxl-netlink-bc640af10673
> 
> Best regards,


