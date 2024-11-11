Return-Path: <linux-can+bounces-1955-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7586B9C407A
	for <lists+linux-can@lfdr.de>; Mon, 11 Nov 2024 15:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 996551C21157
	for <lists+linux-can@lfdr.de>; Mon, 11 Nov 2024 14:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E375156F39;
	Mon, 11 Nov 2024 14:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="qSB5AosX";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="87hDBwfo"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596FF19E98C
	for <linux-can@vger.kernel.org>; Mon, 11 Nov 2024 14:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731334504; cv=pass; b=Ly8QHdbaIKliLzvE3+eDMivNH48DA4mo2CHGmmskRKYwhO5pHR36L7NKLU9y4po0JAyOURehs49PmkDQQg0EMMcQ5JLntFb0KBjbvtpYxP7sawNBq1JbcYJCZjylBIcvjmlS4HK0CIJamTggs6XIzNya6HlBH9GIjzSt7hFo3yE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731334504; c=relaxed/simple;
	bh=0x4Fz1h1sQTXEouJAJ7GCgr8RzxanDas7Yvgl2LdIVg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rIEDNB0Zl6PfegBv9ZnLvPKTgfpvomgBcjkZLgbuS/lAXlSTHtck9aODJjmm9K1pUs7ap/fOkfG8S/+duPj21oMMNVkAq/c3TZDiqwqFvm5e2bhMP8+f/vekT2QgR+GOKg3V6DcXuIW5osq8qUBrJNd5JtydkD16ww/9oV9CZHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=qSB5AosX; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=87hDBwfo; arc=pass smtp.client-ip=85.215.255.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1731334132; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=BNxTD1+Ypz2vKH9vi1JWl8ZNIjt2AkRJV3m/drfY+XLVfLU1JUmgs+T0VoypX+3Aka
    SvIaE0w56ZWFQ6D1W9UHdLrccfD0yh9jtlScsXs/y/Rl3fGouX/qWaJG2E6J1g2zGgld
    jhsupCo4n2QesmgdrKKrZto+XGvV5NtF1MYUuAd3eFz9K1uSU/t73N5cU09+svbCji1/
    Wr/Yk0HOjtqHRzeps74M1/5aENS4eye3KFVggDBD8d8XLrH04YjOM4ue0o7iC0UHBEuH
    QL779oQrq5/V5xhDlaA21vHe3vKPq2fJaORroaESYEOjRKrg2pfuJbl7pPTbp16QsYSO
    B3Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1731334132;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=06jeGFlYED23fxWW26IiCXhnKpyavlzMXvu54LUtjS0=;
    b=UUIFc//Mf++NyU0kXZ6WKlljCCPlPvk6PNOBaFhETWPEWjIG7njtwr2xajCL1nzWsX
    E9ufJ4cF/3U5A6V4A211HrqTw/nzMvWCcTy7aOKqrQFg09p1ofG71J2dpSaXPy0VcQMH
    m+IdJCKuw1nPl5ogm5mAZSi/ovc3KHPatyWiYyWSuMttsNFCNiivFV1LtTfPviVTR4dz
    kK2TGgRCjoSW0w5083/ffxFb77HTkTxxB9SHl8Nzv25u7gDsPXfmdJP5WLoCt9nZmVSz
    MQeK3g+J7d5CCzVxCrYRnEsDRbb8nCui92JU5BmZVubZx82rL5yXxfnKJ2C5926bkFYX
    GLlw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1731334132;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=06jeGFlYED23fxWW26IiCXhnKpyavlzMXvu54LUtjS0=;
    b=qSB5AosXifWdzcp3gF9UBQu9cvof8YuwFuGZF73iMd4bEkN14DmiXU0x4tLhZD0ZZv
    o3dLLyGuvCFE4lqNKdbV7apgw3+QlGWc8THPUPowGTrievsu98h8n7uSX3qA09tRHL3Q
    MIT2WRyQ+fHn2vW/yaqZ8KMSrxCn/4Y1klv84jPt6pF5LdFta0WkjGSudRbq2FUo6ZmU
    Y+jduBicFURid+T970Hf4oIxwMZq37BDZMx8l/mGnBMG6i8fhJOFTo4tbZjLFy5AVCOh
    CwWsQFrBRGPdmNaLEAhsKQ7uw6B2teP6DrtIy5bm6Pn4619LDGze0Nu5ED9zfUqIL/Hl
    k5Ow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1731334132;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=06jeGFlYED23fxWW26IiCXhnKpyavlzMXvu54LUtjS0=;
    b=87hDBwfoN1QPYZaXJ5uypFtrSAj7hotFq93U5DktZnB7HDjUugg3DvIr8W6UxnqVUz
    jfl4QxjOFyKoXRuY+cBA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/vMMcFB+5xtv9aJ67XA=="
Received: from [IPV6:2a00:6020:4a8e:5000::9f3]
    by smtp.strato.de (RZmta 51.2.11 AUTH)
    with ESMTPSA id K63ada0ABE8p7yv
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 11 Nov 2024 15:08:51 +0100 (CET)
Message-ID: <ea52eb8f-c59d-445a-bf4d-26f2772f7426@hartkopp.net>
Date: Mon, 11 Nov 2024 15:08:46 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/14] can: netlink: add CAN XL
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, linux-can@vger.kernel.org,
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Robert Nawrath <mbro1689@gmail.com>
References: <20241110155902.72807-16-mailhol.vincent@wanadoo.fr>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20241110155902.72807-16-mailhol.vincent@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello Vincent!

Very impressive! Thanks for the effort.
Together with the example in the dummyxl driver it should become quite 
easy to integrate the netlink API into my XCANB driver hack for testing.

Picking up the dummyxl driver I wonder if it would make sense to 
mainline this driver probably as can_nltest driver?!?
Of course this driver should be disabled or combined with some kernel 
testing Kconfig stuff. But is it a great testing tool.

 From what I can see with the bitrate and tdc configurations the 
extension for CAN XL is ok.

If you take a look at this manual

https://github.com/linux-can/can-doc/blob/master/x_can/xcan_user_manual_v350.pdf

on page 268/304 you will find the PWM configuration which consists of 
three values with 6 bits each. I assume this to be similar in all CAN XL 
controllers.

The PWM feature switches the physical layer for a CAN XL transceiver in 
the CAN XL data phase. This is a weird feature to do some PWM on the 
controllers' TX data pin to be able to switch the physical layer while 
maintaining the CAN transceiver package with 8 pin layout.

Additionally to this PWM configuration register, the PWM CAN XL 
transceiver switch feature has to be enabled similar to the way we 
enable 'fd on' or 'xl on' today.

You can see this bit called XLTR in the Operating Mode section on page 
269/304 and 270/304 .

E.g. that might be named 'xltrx [on|off]' (default off)

Best regards,
Oliver


On 10.11.24 16:55, Vincent Mailhol wrote:
> Because of popular request [1] and to celebrate the fact that I joined
> the kernel web of trust this week [2], here is an RFC to introduce the
> CAN XL netlink support.
> 
> The logic is simple. The CAN XL basically just reuse the same kind of
> parameters as CAN FD: the databittiming and the TDC. So the series is
> just a bunch of refactor to either:
> 
>    - factorize code.
>    - rename some variable to differentiate between CAN FD and XL.
>    - make some function more generic to accept both CAN FD and XL.
> 
> The feature is working™: there is a dummy driver at the end of the
> series to show the traffic from the userland to a driver. This said, I
> did close to zero testing. Once I had one CAN XL frame reaching the
> driver, I call it a day, and decided to send the work. Regardless, it
> is Sunday night. If I do not send it now, that would be next week-end.
> Probably some mistakes are hidden here and there, but this should be
> enough for an RFC level.
> 
> Also, I am not fully happy that can_dbt_changelink() requires 8
> parameters. I will probably revisit this later on. But for the moment,
> I think this is acceptable for an RFC.
> 
> Overall, I do not want to rush this series. Linus should send the rc7
> anytime soon, and the merge window will probably start in eight days.
> I do not think this series will be finalized by then. I still need to
> give a deeper look at ISO 11898-1:2024 [3] to check that everything is
> good. However, if I receive positive feedback on this RFC, I would
> probably like to have the first patch merged so that I do not have to
> rebase that tree wide patch each time someone makes a change.
> 
> I will send a second RFC series for iplink2 just after this one. Stay
> tuned!
> 
> [1] https://lore.kernel.org/linux-can/CAEQ16vpxthctdrpv0kBKEZJA8VNYffjGGPBGBY93RmKDD49bAQ@mail.gmail.com/
> [2] https://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git/commit/?id=81d335d3586c
> [3] https://www.iso.org/fr/standard/86384.html
> 
> Vincent Mailhol (14):
>    can: dev: add struct data_bittiming_params to group FD parameters
>    can: netlink: replace tabulation by space in assignement
>    can: bittiming: rename CAN_CTRLMODE_TDC_MASK into
>      CAN_CTRLMODE_FD_TDC_MASK
>    can: bittiming: rename can_tdc_is_enabled() into
>      can_fd_tdc_is_enabled()
>    can: netlink: can_changelink(): rename tdc_mask into
>      fd_tdc_flag_provided
>    can: netlink: make can_tdc_changelink() FD agnostic
>    can: netlink: add can_dtb_changelink()
>    can: netlink: add can_validate_tdc()
>    can: netlink: make can_tdc_get_size() FD agnostic
>    can: netlink: make can_tdc_fill_info() FD agnostic
>    can: netlink: document which symbols are FD specific
>    can: netlink: add CAN XL support
>    can: netlink: add userland error messages
>    !!! DO NOT MERGE !!! can: add dummyxl driver
> 
>   drivers/net/can/Kconfig                       |   8 +
>   drivers/net/can/Makefile                      |   1 +
>   drivers/net/can/ctucanfd/ctucanfd_base.c      |   8 +-
>   drivers/net/can/dev/calc_bittiming.c          |   2 +-
>   drivers/net/can/dev/dev.c                     |  12 +-
>   drivers/net/can/dev/netlink.c                 | 422 ++++++++++++------
>   drivers/net/can/dummyxl.c                     | 224 ++++++++++
>   drivers/net/can/flexcan/flexcan-core.c        |   4 +-
>   drivers/net/can/ifi_canfd/ifi_canfd.c         |  10 +-
>   drivers/net/can/kvaser_pciefd.c               |   6 +-
>   drivers/net/can/m_can/m_can.c                 |   8 +-
>   drivers/net/can/peak_canfd/peak_canfd.c       |   6 +-
>   drivers/net/can/rcar/rcar_canfd.c             |   4 +-
>   .../net/can/rockchip/rockchip_canfd-core.c    |   4 +-
>   .../can/rockchip/rockchip_canfd-timestamp.c   |   2 +-
>   .../net/can/spi/mcp251xfd/mcp251xfd-core.c    |   4 +-
>   drivers/net/can/usb/esd_usb.c                 |   6 +-
>   drivers/net/can/usb/etas_es58x/es58x_core.c   |   4 +-
>   drivers/net/can/usb/etas_es58x/es58x_fd.c     |   8 +-
>   drivers/net/can/usb/gs_usb.c                  |   8 +-
>   drivers/net/can/usb/kvaser_usb/kvaser_usb.h   |   2 +-
>   .../net/can/usb/kvaser_usb/kvaser_usb_core.c  |   6 +-
>   drivers/net/can/usb/peak_usb/pcan_usb_core.c  |   6 +-
>   drivers/net/can/xilinx_can.c                  |   6 +-
>   include/linux/can/bittiming.h                 |   4 +-
>   include/linux/can/dev.h                       |  39 +-
>   include/uapi/linux/can/netlink.h              |  21 +-
>   27 files changed, 606 insertions(+), 229 deletions(-)
>   create mode 100644 drivers/net/can/dummyxl.c
> 


