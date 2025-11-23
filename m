Return-Path: <linux-can+bounces-5624-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07FBFC7E605
	for <lists+linux-can@lfdr.de>; Sun, 23 Nov 2025 20:02:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 360EE3A1C71
	for <lists+linux-can@lfdr.de>; Sun, 23 Nov 2025 19:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028741A295;
	Sun, 23 Nov 2025 19:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="Xbtpp2Kj";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="FbJPplAf"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C728436D4F1
	for <linux-can@vger.kernel.org>; Sun, 23 Nov 2025 19:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.162
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763924512; cv=pass; b=MHGnoIjlb/YWdGdUh0mPrkGAf6dw2+yctLzedise3SgUE2F4FAM9PugjQfRVK7ov9ZB/YzWXeHTVN0dk41wRohmTYPOLud/dVCnbJ/kG3kuTJahAMj7zdrgxSgXvKmlWXEgL4avqr5S2xt4Yx7w/yAbg6jKuUiy/81eGPQg8ylY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763924512; c=relaxed/simple;
	bh=I4PE+825LJhzzpnIzP3G2TKpC3yc0maN3yWVxUw57yQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ixDWbXYpM6aVGBlyKGvpyFw+C9zrNQ1nQXdCnkwVBQIRIVt6C0CRLx2j+YbyI31i1gehT0ZqH0DjU2Qk0HfNSvjizXpimOrDwAYUBHBOeXkKVIe3xU/chkO4Fh6Fzq0zivuVKrfOWJuha3CJJW91ukzn2qJc68ti5k3Wwaz+YuA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=Xbtpp2Kj; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=FbJPplAf; arc=pass smtp.client-ip=81.169.146.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1763924314; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=gw7sDvT0g2a4QNeyDGR8W1wAI46lGZg6JTFSnhJhj1NWcTNjC+hu5eESA1JCq6eGmj
    OQi7eKFWM5kPKDWW9GGmZS0IQGaUBhIn8Og4u6nRvtd6fyCuWVLH6V6uk8Tmuo7Dt2CA
    w0Pn+NgGnOouDFbbJnSGmrzYzz7VUsV1Vw7K2AXVovbK7NTF8hu2kGL1vMTvqNB9k7xF
    TtjSVipGqG+irYQj3s25QgsUHdWnDjNo1bzzlgbCibLqS6ZJCRo6F1Gfjb2j2ta23wok
    qnfTtkwO9q9IH1w5jhD9+yMjy+5bjCvQ6SNhV+fGUFk/RHkCWXzEMOArz7SYk0f/+9Ya
    9UrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1763924314;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=gWLC70103HcPilb976PSi0RlJiP+q8aEau5k1PN5pyg=;
    b=Xz/vzW4DNrjLJM3Hdm2BnrGFC0KSQKnqXD6qXXqHz5M6gCc8/HyuhWAWs7H2yjcCPp
    4XpQxRI2zZIlt/ASDIMe6v+2V1624ZPahKO+Xr6MSliBhfRyEaLh08LJJhYTlRCF7Pr4
    3sXfWdkAC8Zu1czfbjvvMz2eETU6hxP2sYZw/XA2w9lRgTGPVbJyCQxufb3G3rlSakmh
    XSmXveaYX3OLOE9/cKL9qGPoHNqTX1ep+ZtY9t2wpxnRUPjlWCL4bi5YEkYFx2nXLzXa
    RubndPJgGPL988H2pbSkzxJF2FLzyZE/sjZvPqKD2dq6YbNvV+7vatd7M31yxex/xgqv
    pguw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1763924314;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=gWLC70103HcPilb976PSi0RlJiP+q8aEau5k1PN5pyg=;
    b=Xbtpp2Kj+bNvr4Ks7x7nQpg4CwdYlJGHLUvPp+b6ifHbebdSvmO/mN1FJVp6MC5DcH
    yEa/Lxcrf7T+XNbs4yrWprkhnjkqfxELuzDGOiNkQ6gwDP21893mPvZi/8Quda0dGRVt
    I4YXiEQADbZMpK4Cff1MuuaUL5szFkP2EPgs8KXUk5XhACSsnlSiQXjI2B0P7SyjlqpY
    kK8EsCdwXDzJsPD4/St7LEMxmflrf+pOEfQbbNH3wPNXmaOd32UhNFPdkFLVzxcoRgkE
    u1g0bSTv8AtJM0O2pGP3nD9A/AXaIKCV3pyY/WzBHaSRR96x3qBoCj9y5gddKML5Fn3F
    JMUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1763924314;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=gWLC70103HcPilb976PSi0RlJiP+q8aEau5k1PN5pyg=;
    b=FbJPplAfITVVZXU3raQ+YdFPzQhXzuZXnWoGJYYgUuV2032cdaGUaZldXXowhodLTi
    mCHw1cvwXmq4ZfoqcZAQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::9f3]
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461ANIwYIEG
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sun, 23 Nov 2025 19:58:34 +0100 (CET)
Message-ID: <feca32b7-9067-4877-ad64-5d4771ca0149@hartkopp.net>
Date: Sun, 23 Nov 2025 19:58:26 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [canxl v6 05/17] can: netlink: add initial CAN XL support
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: Rakuram Eswaran <rakuram.e96@gmail.com>
Cc: linux-can@vger.kernel.org, mailhol@kernel.org
References: <20251122093602.1660-6-socketcan@hartkopp.net>
 <20251123065230.7869-1-rakuram.e96@gmail.com>
 <41d895e6-1ef5-4658-910f-e1e5fe312702@hartkopp.net>
Content-Language: en-US
In-Reply-To: <41d895e6-1ef5-4658-910f-e1e5fe312702@hartkopp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello Rakuram,

some hints how to create a test setup for the CAN XL patches:

You need to build your own CAN XL enabled "ip" tool from the iproute2 
package. This new code can be found in Vincents iproute2-next tree:

https://git.kernel.org/pub/scm/linux/kernel/git/mailhol/iproute2-next.git/

You need to check out the canxl-netlink branch there:

https://git.kernel.org/pub/scm/linux/kernel/git/mailhol/iproute2-next.git/log/?h=canxl-netlink

Once you've built that branch

./ip link set can0 type can help

shows the new XL specific options.

Of course you need the "can0" interface first:

Load the dummy CAN driver:

# modprobe dummy_can

Enable the debugging to see the output in dmesg :

# echo 'file drivers/net/can/dummy_can.c +p' > 
/sys/kernel/debug/dynamic_debug/control

Then you can e.g. enable the CC/FD/XL mixed-mode without transceiver 
mode switching (TMS):

# ./ip link set can0 type can bitrate 1000000 dbitrate 2000000 fd on 
xbitrate 4000000 xl on

Or e.g. use the CANXL-only mode with TMS enabled:

# ./ip link set can0 type can bitrate 1000000 xbitrate 12308000 xl on 
tms on fd off

After setting the interface to 'up' with

./ip link set can0 up

You can see the settings in dmesg, e.g.

[ 2850.574758] can0: Clock frequency: 160000000
[ 2850.574762] can0: Maximum bitrate: 20000000
[ 2850.574763] can0: MTU: 2060
[ 2850.574764] can0:
[ 2850.574765] can0: Control modes:
[ 2850.574766] can0: 	supported: 0x0000ba22
[ 2850.574767] can0: 	enabled: 0x00003220
[ 2850.574768] can0: 	list:
[ 2850.574769] can0: 		LISTEN-ONLY: off
[ 2850.574771] can0: 		FD: on
[ 2850.574772] can0: 		TDC-AUTO: on
[ 2850.574773] can0: 		RESTRICTED: off
[ 2850.574774] can0: 		XL: on
[ 2850.574775] can0: 		XL-TDC-AUTO: on
[ 2850.574776] can0: 		TMS: off
[ 2850.574777] can0:
[ 2850.574778] can0: Classical CAN nominal bittiming:
[ 2850.574779] can0: 	bitrate: 1000000
[ 2850.574780] can0: 	sample_point: 750
[ 2850.574781] can0: 	tq: 6
[ 2850.574782] can0: 	prop_seg: 59
[ 2850.574783] can0: 	phase_seg1: 60
[ 2850.574784] can0: 	phase_seg2: 40
[ 2850.574785] can0: 	sjw: 20
[ 2850.574786] can0: 	brp: 1
[ 2850.574787] can0:
[ 2850.574788] can0: CAN FD databittiming:
[ 2850.574789] can0: 	bitrate: 2000000
[ 2850.574790] can0: 	sample_point: 750
[ 2850.574790] can0: 	tq: 6
[ 2850.574791] can0: 	prop_seg: 29
[ 2850.574792] can0: 	phase_seg1: 30
[ 2850.574793] can0: 	phase_seg2: 20
[ 2850.574794] can0: 	sjw: 10
[ 2850.574795] can0: 	brp: 1
[ 2850.574796] can0: 	CAN FD TDC:
[ 2850.574797] can0: 		tdcv: 0
[ 2850.574798] can0: 		tdco: 60
[ 2850.574799] can0: 		tdcf: 0
[ 2850.574800] can0:
[ 2850.574801] can0: CAN XL databittiming:
[ 2850.574802] can0: 	bitrate: 4000000
[ 2850.574802] can0: 	sample_point: 750
[ 2850.574803] can0: 	tq: 6
[ 2850.574804] can0: 	prop_seg: 14
[ 2850.574805] can0: 	phase_seg1: 15
[ 2850.574806] can0: 	phase_seg2: 10
[ 2850.574807] can0: 	sjw: 5
[ 2850.574808] can0: 	brp: 1
[ 2850.574809] can0: 	CAN XL TDC:
[ 2850.574810] can0: 		tdcv: 0
[ 2850.574811] can0: 		tdco: 30
[ 2850.574812] can0: 		tdcf: 0
[ 2850.574813] can0:
[ 2850.574813] can0: error-signalling is enabled
[ 2850.574818] can0: dummy-can is up

# ./ip link set can0 type can help

still shows an option

	[ err-signal { on | off } ]

which has been removed in the patches as this setting is automatically 
retrieved from the mixed-mode/CANXL-only mode setting, see reason here:

https://lore.kernel.org/linux-can/20251122093602.1660-8-socketcan@hartkopp.net/T/#u

The state can be seen in the dmesg output:

(..)
[ 2850.574813] can0: error-signalling is enabled
[ 2850.574818] can0: dummy-can is up

Have fun!
Oliver

On 23.11.25 14:13, Oliver Hartkopp wrote:
> Hello Rakuram,
> 
> thanks for your offer to test the CAN XL support!
> 
> On 23.11.25 07:52, Rakuram Eswaran wrote:
>> On Sat, 22 Nov 2025 at 15:06, Oliver Hartkopp <socketcan@hartkopp.net> 
>> wrote:
>>>
>>> From: Vincent Mailhol <mailhol@kernel.org>
>>>
>>> CAN XL uses bittiming parameters different from Classical CAN and CAN
>>> FD. Thus, all the data bittiming parameters, including TDC, need to be
>>> duplicated for CAN XL.
>>>
>>> Add the CAN XL netlink interface for all the features which are common
>>> with CAN FD. Any new CAN XL specific features are added later on.
>>>
>>> The first time CAN XL is activated, the MTU is set by default to
>>> CANXL_MAX_MTU. The user may then configure a custom MTU within the
>>> CANXL_MIN_MTU to CANXL_MIN_MTU range, in which case, the custom MTU
>>                      ^^^^^^^^
>> Minor nit in this description. It has to be CANXL_MIN_MTU to 
>> CANXL_MAX_MTU range.
> 
> Definitely ;-D
> 
> Thanks for the feedback!
> 
>>
>>> value will be kept as long as CAN XL remains active.
>>>
>>
>> At the moment, I'm going through the mail series. I would like to apply
>> patch series in a local branch and test with dummy module. For that
>> purpose, if I apply this series on top of linux-mainline will it work?
>>
>> If not, please share the base commit details to experiment locally.
> 
> The patch set applies on the net-next tree:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
> 
> Alternatively you can also apply the patches to the current Linux 
> mainline tree after you applied this patch here:
> 
> can: treewide: remove can_change_mtu()
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/ 
> commit/?id=f968a24cad3da72
> 
> Best regards,
> Oliver
> 


