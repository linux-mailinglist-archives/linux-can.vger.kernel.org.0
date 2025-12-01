Return-Path: <linux-can+bounces-5795-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D0AC98665
	for <lists+linux-can@lfdr.de>; Mon, 01 Dec 2025 18:03:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 838F73A4670
	for <lists+linux-can@lfdr.de>; Mon,  1 Dec 2025 17:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69EC20A5EA;
	Mon,  1 Dec 2025 17:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="SkoLSgcp";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="VvB+wkV7"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC9D31813F
	for <linux-can@vger.kernel.org>; Mon,  1 Dec 2025 17:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.221
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764608536; cv=pass; b=n1yNm8CPANtsDcL0fNALY0D07iFdm2iMlFF9eoG2WtniWTPTOBAjstbcqBQUS3nf1gazSZz1wcBJDKVD89NUT4eUKivHx2csiSuwbjfRxhpvkJN8TI07+YYMCd0X21ESOGnLBJKSWlrjNdMSUzAuUEm8blI4mxodPhvLKtZKv7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764608536; c=relaxed/simple;
	bh=33lSUuSrrzqew268f3MOr8DGFxsaSTlXItEuNNYbNyE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=DzSxfo5nC1E2ArTNkpgf2srWe3ltZXWjieqeUUkCJubAZNgFRhQ9gE81I77/JkCIzkjjpmKIpiQyfj06paw48379S21NrcMwwRfHoa09a7SQVpMxJNTS3LpHbG+3fPzrM5K8q2vBpM222uQRg4WCFjWUR+VA1ICQI/iZSaya+LY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=SkoLSgcp; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=VvB+wkV7; arc=pass smtp.client-ip=81.169.146.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1764608524; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=eFK6yphV+HoTFX0dvQyIQQvXuA9lbccWy3vUuRSPnEMfKUdGc0mePm7wWzJnlNYzRI
    Z11lgNbksNk7NIG2HxrN3HL3bvjmLXXGVtb/4VF3DdOrG+iNt+3Jo4M8for8P5Hf6SzW
    9QnydxKrXt/I6Gw0NMvVsJfVfQ1xi+7Pss0KYmIMXByxwZsF7ODjU9KiEQUVXCJz3bt/
    FaFcXlM8lalU0scjBewb+CDlOXOlsGigs46DQAye0VwXzmA1d/c5qWNTl8xbxiC0LzLs
    Vw2jStk7mIVBtPEuGEv3duY285i/LH0azWLSlajM09OTOy72u3VBeBjXzsTDwzpq8lQ+
    ZLjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1764608524;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=1MK8IP3Cvv00zBJOuT/A2Xa7jWloJk4VdGfyDpOGdyo=;
    b=lR+uG8bLF5/67Ll0yhTY4GEx7hfAo7nMmMNi6pQLSE1g9pN3x4YK/UXw+ZB+kZw5UO
    LNzHMUBeLwzBBD5B61kSwub311tq1kWUmGvCfmgzKWOdvNZN3VKPGihDsP2w9Ftbo0Es
    mLphB1cU4dcM0qteC3Vu7LKZVAnf9VRDFWeM69krC5RyIIcEeCUWRVWKu1HgeMYmeAgU
    s9NgBGvj25NpDblqh92T8TJSF7k/z5vQKY/c1eh4T9yT5gGhMdFVO0tmzr2iy24igevc
    L2PlLIIXSvTYoimSulHBCwUAtUN1bw66R44T37OPij52WgtabhCt6CkPL2dYP8NLKAGM
    U+Hg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1764608524;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=1MK8IP3Cvv00zBJOuT/A2Xa7jWloJk4VdGfyDpOGdyo=;
    b=SkoLSgcpfNwTeKnk0Sh4VMptM9B5hp98mfdxQQZlYDEVE3WMQzzOyPRcLjAmWVSBmz
    CSt40VbMuj2laVcGFmLggcHGkW829Y4RvrfwMbRyGTiEUnY6fko889g7cSuxav/e8rlD
    UljFjJorr1PqGGr8714RGInoydX4D5A7dsTm7YE/xt3TdDJMJXDkyZCxF9FZi9tCE1YW
    8+vx3Co+aUFP8RTFEjAbW3ewXhgaFvN3Ut+PDqPsGM+Wa0QzwpzpxqRv6pk9Bq8HVjvt
    hrdcGmvlf4cyB8eKt5jmqpmQkqIo+4CFvkBy3ruhH8YIlEhSQv4Vq4WULZMcP2q/Fwp5
    H8pg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1764608524;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=1MK8IP3Cvv00zBJOuT/A2Xa7jWloJk4VdGfyDpOGdyo=;
    b=VvB+wkV7t6w0XQBQ8KGccI5nAUPFj9Uo5h//VoCKjatsBV+ffnIzyrl4BZ85zkBo1m
    Q4DeXMCi6b7bTRrqNmAw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeFQ7s8bGWj0Q=="
Received: from [IPV6:2a00:6020:4a38:6800::9f3]
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461B1H24xRD
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 1 Dec 2025 18:02:04 +0100 (CET)
Message-ID: <931bc305-f575-47e2-a7f7-62e2f179e75d@hartkopp.net>
Date: Mon, 1 Dec 2025 18:01:59 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ip command using uninitialized flags?
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: Vincent Mailhol <mailhol@kernel.org>,
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org
References: <49120f0f-d05d-471c-8e9a-fbce75161e4e@hartkopp.net>
Content-Language: en-US
In-Reply-To: <49120f0f-d05d-471c-8e9a-fbce75161e4e@hartkopp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Vincent,

when you are working on the next patch set for iproute2 can you please 
also take a look at this issue?

This wasn't a bit thing with CAN FD only - but now having FD/XL/TMS the 
initialization of those defaults to be "off" before parsing the command 
line would be better IMO.

Best regards,
Oliver

On 16.11.25 20:42, Oliver Hartkopp wrote:
> Hi all,
> 
> switching from mixed-mode (FD/XL) to CANXL-only with TMS on the FD flag 
> seems to survive:
> 
> Here FD is set to on:
> 
> root@de1soc1:~# ./ip link set can0 type can bitrate 1000000 dbitrate 
> 2000000 fd on xbitrate 4000000 xl on tms on
> Error: TMS and fd are mutually exclusive.
> 
> And here FD is not set but still seems to be active:
> 
> root@de1soc1:~# ./ip link set can0 type can bitrate 1000000 xbitrate 
> 4000000 xl on tms on
> Warning: TMS can not be activated while CAN FD is on.
> 
> Is this a common pattern not to modify flags that are not explicitly 
> defined?
> 
> Or should the flags be zero-initialized with the defaults (0 = off) ??
> 
> Best regards,
> Oliver
> 
> ps. IMO the "Warning: TMS can not be activated while CAN FD is on." 
> should be an "Error: TMS ..."
> 


