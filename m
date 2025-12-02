Return-Path: <linux-can+bounces-5806-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 248BDC9AD1E
	for <lists+linux-can@lfdr.de>; Tue, 02 Dec 2025 10:18:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C2C584E24F0
	for <lists+linux-can@lfdr.de>; Tue,  2 Dec 2025 09:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A6B29BDB0;
	Tue,  2 Dec 2025 09:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="AkM33L3a";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="07PRTD6d"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A963325D208
	for <linux-can@vger.kernel.org>; Tue,  2 Dec 2025 09:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764667106; cv=pass; b=IaDCOICmW0fxLcLqOlsPxpSfvtRDCZeN+HYqy0WmcmgSePZBx9x4Bcc4t6pVgJDonKAQNKXp1EGQpepzvITzqwA33C/TtyhvMqf9h+7ow+5UFRFwcWP9r0D8ynA2uSoKZy71oFO2MOGnhvr8WTwVjmSz2/6B6irEaB1mG2ZQ8kk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764667106; c=relaxed/simple;
	bh=Wp26pqKNryYXzZPcpzl6YmtyUUwzhOMsWhfu0URInxU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gruSwq9khs3CNcX5PeiWEgDfCVMmyxZcWdrsajE+CnRkaPFd7IPsgiGpvJJG/S5POdFW0oTRA25/v592M0QvTFpB0y102YxdmTXx45VLSuPOWdzhrjdN3MWvKE6eZoRAWpMYox9DOaAz4MiTnNPcXyvMzQlimMMg4v7gPXTn5Ks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=AkM33L3a; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=07PRTD6d; arc=pass smtp.client-ip=85.215.255.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1764666376; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=k/peHYDJBuEjsjqXSBUI4MoLTiLhJVG9Ms+t/G1HeNCtRYtcKTTL7/VJU8PDf65dap
    +ZDsuhr93yW99zEdTFK/6m/UzHsWjm/UxlyNxw9cJwBDgBtF+Yc4VVEg5+pj85mRWrEG
    NHQn3BoSWNNPVgm1pswMF2kf0oW0fOhSCuRi6+eZnWCSbhv0f05QdFBhaAlSCAaeIm0M
    9zBKiqG1kP+c0aL0rVhYLkIeLPrFY/xYI6j2v6Z0IRGOZkJs3BDwIfznqQhumK+lgEbP
    At9jXFHHOpvOFQQWGBjcrBvQSsYWiwoeSFzKC2mKE/J2hoNUeUFFMtPcLzTWH0Bj006c
    GVuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1764666376;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=F38fLqzAmvnGJZeif6XlRcz7NTspOdeZdusb7cJSRNg=;
    b=jSpFTdLdr+CyiC1i0ciVJQRRVQd02NkeZiSCBIFEIcnWLuezeCaJKaMP/gZ4vMjt6R
    JG/kp8N5bCoJkfxKvYYs01uwLvWOJ9MccmALTy47k46WXPdz54kmyI13/iayu6R/DlW8
    FhkcapCJUpQmC14EkRUoOWaaWWAixIwZHjHwjCp7YUTa2ch7jcor1KfenEyNqk5KlRWZ
    RSLAy34Q2rw0yu39fs/l+ZZlOGS6g3QWZvq1M1tSvhNzPTB1gsqtjOJRusPYOrqLRKVu
    Krfy3NV/8J3nXerMtg86qLH95GvI51eBjhcPS6Q4zb2JRfA9JsBETLO5mMcyhBVSUgwL
    DncA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1764666376;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=F38fLqzAmvnGJZeif6XlRcz7NTspOdeZdusb7cJSRNg=;
    b=AkM33L3aKlpe18L//N1y2jwnQytXBygz6JOuvQ6GsuZtK9wUs10robxXh5D6T/1fz/
    Bo77g11BihyqwIdF8Ac3wK3KvrJwMq1zzLv4cgszZ1myeNayb1Idda/4eRzHB3SM7UGU
    gJdjuDUT/hbp5/AGCXPJ6OWzw+4KHDPELf6aZULT0h9qtHFwp1GP63ZMWH2c48r7bhN8
    qMCC3jPMM76Ejptl1v4sRGBR7JridU0BMe/2yXzgSuWYEoNcy+2hca7+Nvqbvi9OVqTf
    5oNuib67UpEn3XxekYbwAOj59VKy80EXvkD3LcGHpSgf0wWp1OmltImb+2mpqFmY/ahT
    w4NA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1764666376;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=F38fLqzAmvnGJZeif6XlRcz7NTspOdeZdusb7cJSRNg=;
    b=07PRTD6dbpmu7Mh2odEjcVqSdnRLoxURR/oJ9QFeTr7jQTIpIoOoBm3TmuzRGs9djX
    nI+NM9b3fW0oyHZXqsBw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::9f3]
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461B296G2Uh
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 2 Dec 2025 10:06:16 +0100 (CET)
Message-ID: <1ffee580-112e-4b21-836d-f6377d4cab08@hartkopp.net>
Date: Tue, 2 Dec 2025 10:06:10 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ip command using uninitialized flags?
To: Vincent Mailhol <mailhol@kernel.org>,
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org
References: <49120f0f-d05d-471c-8e9a-fbce75161e4e@hartkopp.net>
 <931bc305-f575-47e2-a7f7-62e2f179e75d@hartkopp.net>
 <d4a8d6bc-dcc2-4e93-b52d-72754821e450@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <d4a8d6bc-dcc2-4e93-b52d-72754821e450@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Vincent,

On 01.12.25 23:50, Vincent Mailhol wrote:
> Hi Oliver,
> 
> On 01/12/2025 at 18:01, Oliver Hartkopp wrote:
>> Hi Vincent,
>>
>> when you are working on the next patch set for iproute2 can you please also take
>> a look at this issue?
>>
>> This wasn't a bit thing with CAN FD only - but now having FD/XL/TMS the
>> initialization of those defaults to be "off" before parsing the command line
>> would be better IMO.
>>
>> Best regards,
>> Oliver
>>
>> On 16.11.25 20:42, Oliver Hartkopp wrote:
>>> Hi all,
>>>
>>> switching from mixed-mode (FD/XL) to CANXL-only with TMS on the FD flag seems
>>> to survive:
>>>
>>> Here FD is set to on:
>>>
>>> root@de1soc1:~# ./ip link set can0 type can bitrate 1000000 dbitrate 2000000
>>> fd on xbitrate 4000000 xl on tms on
>>> Error: TMS and fd are mutually exclusive.
>>>
>>> And here FD is not set but still seems to be active:
>>>
>>> root@de1soc1:~# ./ip link set can0 type can bitrate 1000000 xbitrate 4000000
>>> xl on tms on
>>> Warning: TMS can not be activated while CAN FD is on.
> 
> The first thing is that under the current design, flags are kept on by default.
> 
> For example:
> 
>    # ip link set can0 type can bitrate 500000 fd on dbitrate 2000000
>    # ip link set can0 type can bitrate 1000000
>    (...)
>      can <FD,TDC-AUTO> state STOPPED restart-ms 0
>    (...)
> 
> Here, FD is still on despite not being specified the second time.
> 
> Then, for CAN XL, the same behavior is preserved:
> 
>    # ip link set can0 type can bitrate 1000000 fd on dbitrate 2000000 \
>      xl on xbitrate 8000000
>    # ip link set can0 type can bitrate 1000000 \
>      xl on tms on xbitrate 20000000
>    Warning: TMS can not be activated while CAN FD is on.
> 
> Here, the second command is the same as:
> 
>    # ip link set can0 type can bitrate 1000000 fd on dbitrate 2000000 \
>      xl on tms on xbitrate 20000000
> 
> because FD is still active from the first one.
> 
> And then, there is your command:
> 
>    # modprobe -r dummy-can
>    # modprobe dummy-can
>    # ip link set can0 type can bitrate 1000000 dbitrate 2000000 fd on \
>      xbitrate 4000000 xl on tms on
>    Error: TMS and FD are mutually exclusive.
>    $ ip --details link show can0
>    (...)
>      can state STOPPED restart-ms 0
>    (...)
>    # ip link set can0 type can bitrate 1000000 xbitrate 4000000 \
>      xl on tms on
>    # ip --details link show can
>    (...)
>      can <XL,TMS> state STOPPED restart-ms 0
>    (...)
> 
> When I try what you did on a clean set-up (thus the "modprobe -r dummy-can"), I
> can not reproduce. So it seems that the FD flag was still active from an earlier
> command. Or maybe you fixed some behaviour in your last series? (sorry I did not
> check the evolution of the code).
> 
>>> Is this a common pattern not to modify flags that are not explicitly defined?
>>>
>>> Or should the flags be zero-initialized with the defaults (0 = off) ??
> 
> My pick is that there is an establish behaviour that the flag should stay as-if
> if not specified (c.f. my first example). So zeroing out all the parameters
> would be a kind of API breaking change.
> 
> The exception is that setting off a "parent" option will forcefully reset any
> child option because otherwise, these would become invalid. For example, doing
> "fd off" will wipe all the fd bitrate parameters (dbitrate, dsample-point, dtq,
> dprop-seg, dphase-seg1, dphase-seg2, dsjw,tdcv, tdco and tdcf). Same for "xl off".

Talking about child and parent settings IMO points out the entire 
problem here.

To me preserving settings in this way is complex and harder to 
understand for the user than providing all necessary settings in one chunk.

When the user initially configures the interface there is no problem and 
also no "API breaking change".

But when you are starting to experiment with settings, switching things 
like FD or TMS on and off, there are always settings and artifacts 
available from former ip calls. And you are urged to have them in mind.

We maintain a "context of former configuration attempts" inside iproute2 
and the kernel that is hard to follow and not needed IMO.

Maybe other users can show up here how their expectations with modifying 
existing settings would be.

>>> ps. IMO the "Warning: TMS can not be activated while CAN FD is on." should be
>>> an "Error: TMS ..."
> Indeed… I will not be touching the kernel code for the next couple weeks because
> of some other personal priorities, but this is a valid point.

No problem. This is not urgent and maybe it can stay as-is now.
It would have been a thing while the series was prepared for upstream.

Best regards,
Oliver


