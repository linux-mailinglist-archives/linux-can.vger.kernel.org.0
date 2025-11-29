Return-Path: <linux-can+bounces-5786-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E6CC9458C
	for <lists+linux-can@lfdr.de>; Sat, 29 Nov 2025 18:21:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F0C284E1A07
	for <lists+linux-can@lfdr.de>; Sat, 29 Nov 2025 17:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A04926B2D7;
	Sat, 29 Nov 2025 17:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="EtfVgxvg";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="3tpOlhQr"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5A1217659;
	Sat, 29 Nov 2025 17:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764436890; cv=pass; b=NIks/BESY2eqzJIqH9pAJjpFKCWrvrYxuMCVbw160Y9bmNGcWtaNzZD1sxyXzwEFPO7g+k6DOZZQQZaKukfxXX7j5sXCd+ChDrx5onsuPLicqM2z7Pbfs3XM0a73tXN4Oa7oUHc+tpI9tmR38t1+eQSktfmXN9q2bQHG6ni44ZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764436890; c=relaxed/simple;
	bh=xHLnWWhsni+9Yk97MkwEW36Y92wG3tfvsdRUAGiJP40=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bu9X78qpudbW0u6b5aDiO+0borzE2hJBDFU5IeHtNUbaBkcQCpxpPmgrdmWFyDHM1+/bD1IOfyHEXv++il+m7Tn4h1NdwxmdQaGGCwROJkzt1BXsnVAfeiw3oZAn3HjJJpy1zO0IA0YdNpHDO3iidB2a2lhIHMfITGsDYcXeZCo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=EtfVgxvg; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=3tpOlhQr; arc=pass smtp.client-ip=85.215.255.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1764436877; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Z0F3A4v5lpG4uI9IrVJGW2mPhsLLKpSIjUqcs9rM+bLWOXmdmwy6u2G9QK6kUp2t76
    MRs+CAVOymGwVwY+Hit2NF3TTeaD80BoCE/RxcX6lzdtNxUO8/yFpnb2zoYiitu9mqBZ
    kxLhuKkSFWiiPhvHquFexhgPAo9IIvgdvE9hmIEjqgJMmJV3A3ffKxIq3FUliezbuPNO
    JKVNaW0Xnsr4VCNmpfjmiXQSa88LBHUqIu0v4nwW4/ETLWBKeyOoE3kqulN8GmwyJkvG
    ahTa3KhXzUjF/eJcjECQIJVRUq8kdsE0SVNFDbKT53qzCWiNrzhkCGxvxzAv6qFiHA3V
    0jEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1764436877;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=n+oD9KTNyS/pI9ng39RhfdqnlhgRk3Q6tnA3RNLoV9E=;
    b=YRekNebrNLKLXblm6/0/k9jrNLP1APLtaJaDhxZm8+wWDJpFc2EmAE9+Fq/fx0Robb
    EVBuCw0v/LvwkyPuBOAqoFuigv1Ilkdwn0M0ivm6tT/CCqsejRA6KF114jpQKZBkPZ11
    YYtv2KDUINItaZpgjhp/8qyGrU7Ko3tVDIGZFTf4JZwCZcpbsnMcB5D447QFTomF96io
    ptyLHW0D7Yt5q8VweSAY/ORksS7C+7E5pxVPrT2SpYCqHCVmSJoHVFa26r5xdcMaG4Vw
    huLGzvR9zJlVeGxMFF97s/UbHU/thMrqKj9oZuDNbHLDKd4mPw7v4JH1P4KhOC0H9yH5
    VrVg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1764436877;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=n+oD9KTNyS/pI9ng39RhfdqnlhgRk3Q6tnA3RNLoV9E=;
    b=EtfVgxvgtdnNhzfBS61mA6HwpvllWC6Yr+6NxVm8mxnIF3xKSXh+mFSRcOmdQjf2Zy
    gxG9tit38xAqI8yAYeG7GDrLbqH2hjaJW/T4HFNGMpuNsHiuILSuRohrvMC1CM4hgNWg
    jZe5BbWYuEhPlD23BrVx0yrycofCRNSeTf9BlM5Sy3crchYbEmJxO5NJfksAV6v5jicl
    lzf0AsSmOOdHSt24dHT0cqwkq1iOKYJE+8QYAIVH/ZX50M+lUz9t6luk/GIiPOY/ioQY
    bOumu2wrrOw9/hmei721Cv+rdkcYAfyqTdBiDEu2aF/rHKhKVLJlsplntAZCjcSA6bOo
    2ACw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1764436877;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=n+oD9KTNyS/pI9ng39RhfdqnlhgRk3Q6tnA3RNLoV9E=;
    b=3tpOlhQri0sZL+I9sp8snm8oZHO8VSvplQ08WGCu7tEygLDwbfWkxVk+sjfM8Htjhl
    3yptKLkjDqjrK3LU3DAg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::9f3]
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461ATHLHk0S
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 29 Nov 2025 18:21:17 +0100 (CET)
Message-ID: <d2e94a1f-b2f3-473a-babe-76fd0fed0ab9@hartkopp.net>
Date: Sat, 29 Nov 2025 18:21:17 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] iplink_can: add CAN XL's "tms" option
To: Vincent Mailhol <mailhol@kernel.org>, netdev@vger.kernel.org,
 Stephen Hemminger <stephen@networkplumber.org>,
 Marc Kleine-Budde <mkl@pengutronix.de>, David Ahern <dsahern@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-can@vger.kernel.org
References: <20251129-canxl-netlink-v1-0-96f2c0c54011@kernel.org>
 <20251129-canxl-netlink-v1-6-96f2c0c54011@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20251129-canxl-netlink-v1-6-96f2c0c54011@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Vincent,

On 29.11.25 16:29, Vincent Mailhol wrote:
> This is the iproute2 counterpart of Linux kernel's commit 233134af2086
> ("can: netlink: add CAN_CTRLMODE_XL_TMS flag").
> 
> The Transceiver Mode Switching (TMS) indicates whether the CAN XL
> controller shall use the PWM or NRZ encoding during the data phase.
> 
> The term "transceiver mode switching" is used in both ISO 11898-1 and CiA
> 612-2 (although only the latter one uses the abbreviation TMS). We adopt
> the same naming convention here for consistency.
> 
> Add the "tms" option to iplink_can which controls the CAN_CTRLMODE_XL_TMS
> flag of the CAN netlink interface.
> 
> Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
> ---
>   ip/iplink_can.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/ip/iplink_can.c b/ip/iplink_can.c
> index 24f59aad..3e7925e8 100644
> --- a/ip/iplink_can.c
> +++ b/ip/iplink_can.c
> @@ -49,6 +49,7 @@ static void print_usage(FILE *f)
>   		"\t[ restricted { on | off } ]\n"
>   		"\t[ xl { on | off } ]\n"
>   		"\t[ xtdc-mode { auto | manual | off } ]\n"
> +		"\t[ tms { on | off } ]\n"
>   		"\n"
>   		"\t[ restart-ms TIME-MS ]\n"
>   		"\t[ restart ]\n"
> @@ -127,6 +128,7 @@ static void print_ctrlmode(enum output_type t, __u32 flags, const char *key)
>   	print_flag(t, &flags, CAN_CTRLMODE_XL, "XL");
>   	print_flag(t, &flags, CAN_CTRLMODE_XL_TDC_AUTO, "XL-TDC-AUTO");
>   	print_flag(t, &flags, CAN_CTRLMODE_XL_TDC_MANUAL, "XL-TDC-MANUAL");
> +	print_flag(t, &flags, CAN_CTRLMODE_XL_TMS, "XL-TMS");

print_flag(t, &flags, CAN_CTRLMODE_XL_TMS, "TMS");

That fits to the command line option and the messages inside the kernel now.

Best regards,
Oliver

>   
>   	if (flags)
>   		print_hex(t, NULL, "%x", flags);
> @@ -333,6 +335,9 @@ static int can_parse_opt(struct link_util *lu, int argc, char **argv,
>   				invarg("\"xtdc-mode\" must be either of \"auto\", \"manual\" or \"off\"",
>   					*argv);
>   			}
> +		} else if (matches(*argv, "tms") == 0) {
> +			NEXT_ARG();
> +			set_ctrlmode("tms", *argv, &cm, CAN_CTRLMODE_XL_TMS);
>   		} else if (matches(*argv, "restart") == 0) {
>   			__u32 val = 1;
>   
> 


