Return-Path: <linux-can+bounces-7939-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LmGeDwvDRGrd0QoAu9opvQ
	(envelope-from <linux-can+bounces-7939-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 01 Jul 2026 09:34:35 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CFAAA6EAAEF
	for <lists+linux-can@lfdr.de>; Wed, 01 Jul 2026 09:34:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=hartkopp.net header.s=strato-dkim-0002 header.b=OLHxW+yj;
	dkim=pass header.d=hartkopp.net header.s=strato-dkim-0003 header.b=UePeuVdw;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7939-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-7939-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=hartkopp.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 870153032183
	for <lists+linux-can@lfdr.de>; Wed,  1 Jul 2026 07:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4AD03B7B9D;
	Wed,  1 Jul 2026 07:34:23 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622D13B9DA6;
	Wed,  1 Jul 2026 07:34:18 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782891262; cv=pass; b=AskkfLM9VHm+Tzyqso1iA4Xw1F+OMJ5ILb4rhfSVu7fE1Qphi6hrQmoOtHqHTGRzod5p+S0BA/Ph+ExFGl/cJbD3q7Pzidaa3B+kn/KsCQlPA26RDJDR+fcu/zWYVUS22ONS0oe6lIcOR70PvWTR7myVdFgIDFHgr7vRM+4h+nk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782891262; c=relaxed/simple;
	bh=zdngiYe3hiGuB/DLkOqIeGMaVFY/0fAWBToeALIgXOk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eU2B1bKNrEAOar2zFKamHpNHiqFq9RJGCLytqfZGy5nrg5ttHg6awWNw0OHQbeCTbyKq/H1lhDqCrY0LZh+hR+Y8IfHBRzh1o+shUpR+K35f/uDK8Ww8j9fbLibvOPHLPVlKxIpZ4+fB2m9L8krR/1H4GOTVN80WGMCMYbMsBGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=OLHxW+yj; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=UePeuVdw; arc=pass smtp.client-ip=85.215.255.20
ARC-Seal: i=1; a=rsa-sha256; t=1782890537; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=PKisPJSX+3JiBW+nLGaBqudExXDV0Q8c+Q3OGjBdPsHW11jw4Gv0rKPvGzAO4Ovrlc
    m/V94J1Ehy2x14I62eO48Y/5AIlyjGFCj64nfrBKT8oFMUnYzJGl310t+xr6/SsVbOfH
    og5obMJN1wb5Ygt6zFK860A7ZrPY8qbv6zoZrro/UfoqslgZQ15mnKCtBi9jLDj/r3N0
    BuEvXHR/Ls+K5hcVrpsfVoSn+FaL9eEMje5OSHozJqQvtC/1ukLVyd0lkRFH4zNAXYeM
    4GYQtGrsIh1gxR/dbPXr5m8d0mlprEa9lS/qzWuHjsU8s9WIGkr2SWOd0ZvOKHH2HzjD
    YtAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1782890537;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=7lyqMtp60uZ9+hRYovTWLV7HZ6UlWlv6eCjV9bfXWDg=;
    b=dfwVgPrZgpCFhQ80LCtvX9FslVN4djgY+wRWnl3b/8APHBola2AkOf7/L1rs+FrFgp
    tjmS+CsN8WzUnQovIC050vflmizWbE22FwSW8BKERqIolOJ8pUcviGeEvR1mZu+P37jo
    XzJJkLTCCc9MOHzAPKLSUljzWFgOIpmEPEp6A+zb6ZyN+Es1hPoqppbj0J2lfsEaY7gE
    8eHPzw3+mjzfoupfqtk3CaimEk4IMPEoFjWKjgs4HMWfPezK/u8Ow/4lPICMVSC5U9cq
    9RE78PKbBm3g5OOKf19cyshhgMd0hzIIXdzH8AnDfNrqTEHupGqPMTLknN40dbHTb1X4
    TzwA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1782890537;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=7lyqMtp60uZ9+hRYovTWLV7HZ6UlWlv6eCjV9bfXWDg=;
    b=OLHxW+yjSHXNWMk4vuoAIDSqD/5Usp8/Gv1P5qHJNVmIKQZfR1ZZU2g41S9wtIuSTY
    M5zumz2t6cKtLzl+EprX5bX8L9fEHdx7ksEzQr+tVGBsVWhfDwAUTYO6MCFWJgm/DKBd
    a1bNYtdBhYDdXQrTcRKe4WrN8b94Y0MTEAeQ+Jds6ZFcDWQGA5G0xYKuG9gEkLMdj2YZ
    whmxgXWHrLXaUsc3R51soABvZXVsGu61ioSfp6dBpI1mWbAu9zUpGHGKCnHjszxtY/Dg
    Q9ZyehhjfTI6LoI3+R6/kCcUQl6pcg8Yfj2A6UhAZzHpb8BE3FbJVu/wj5DcKO4uPqL1
    NOqA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1782890537;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=7lyqMtp60uZ9+hRYovTWLV7HZ6UlWlv6eCjV9bfXWDg=;
    b=UePeuVdwfqVUR+4CI9tBy5xsj/voNQBER0A2/mjZ7KJHFL/0u/sdJ1QxyvF0STJS1q
    BUWB8gpMCeqC2ApgXTBg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from [192.168.20.111]
    by smtp.strato.de (RZmta 55.5.6 DYNA|AUTH)
    with ESMTPSA id Ka9fdb2617MGtG5
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 1 Jul 2026 09:22:16 +0200 (CEST)
Message-ID: <0212a7f9-b26e-4c15-984d-066ca87fd85e@hartkopp.net>
Date: Wed, 1 Jul 2026 09:22:09 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] can: gw: validate checksum indices against frame length
To: Pengpeng Hou <pengpeng@iscas.ac.cn>,
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
References: <2026063009033007.3-ccfa108-0042-can-gw-validate-checksum-in-pengpeng@iscas.ac.cn>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <2026063009033007.3-ccfa108-0042-can-gw-validate-checksum-in-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[hartkopp.net,reject];
	R_DKIM_ALLOW(-0.20)[hartkopp.net:s=strato-dkim-0002,hartkopp.net:s=strato-dkim-0003];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7939-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pengpeng@iscas.ac.cn,m:mkl@pengutronix.de,m:linux-can@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[hartkopp.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,iscas.ac.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CFAAA6EAAEF

Hello PengPeng,

many thanks for your contribution!

On 30.06.26 09:29, Pengpeng Hou wrote:
> CAN gateway checksum parameters are validated against the maximum Classic
> CAN or CAN FD payload size when the route is configured.  At runtime,
> however, an individual frame may carry a shorter payload.

Right! I definitely get your point.

But the cf->len has to be seen as a magnifying glass when looking at the 
resulting CAN(FD) frame content.

With the modification rules AND,OR,XOR,SET always the entire(!) CAN 
frame content is modified - no matter what the cf->len is.
So it is possible that content is changed that is 'behind' cf->len.

Simple approach: As long as it fits to the CAN(FD) frame data structure 
the modification is applied.

Same applies to the XOR/CRC8 modification rules.

With your patch this simplicity would be removed without adding a new 
benefit. When the creator of the modification rule created an 
insufficient rule he will get an insufficient result.

With your patch the result will still be insufficient - but with 
different (insufficient) resulting content as you stop the processing at 
a different point.

As there is no qualitative improvement for the implemented functionality 
the patch finally would only add complexity, sorry.

Many thanks anyway and best regards,
Oliver

> 
> The checksum helpers use from_idx, to_idx and result_idx to read and
> write cf->data[], and the CRC8 16U8 profile additionally reads
> cf->data[1].  A configuration that fits the maximum frame size can
> therefore still access bytes outside the current frame's valid payload.
> 
> Validate checksum source and result indices against the current
> cf->len, and require byte 1 to be present before using the CRC8 16U8
> profile selector.
> 
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---
>   net/can/gw.c | 35 ++++++++++++++++++++++++++++++++++-
>   1 file changed, 34 insertions(+), 1 deletion(-)
> 
> diff --git a/net/can/gw.c b/net/can/gw.c
> index 0ec99f6..5911afb 100644
> --- a/net/can/gw.c
> +++ b/net/can/gw.c
> @@ -318,6 +318,19 @@ static inline int calc_idx(int idx, int rx_len)
>   		return idx;
>   }
>   
> +static bool cgw_csum_idx_valid(const struct canfd_frame *cf, int idx)
> +{
> +	return idx >= 0 && idx < cf->len;
> +}
> +
> +static bool cgw_csum_range_valid(const struct canfd_frame *cf,
> +				 int from, int to, int res)
> +{
> +	return cgw_csum_idx_valid(cf, from) &&
> +	       cgw_csum_idx_valid(cf, to) &&
> +	       cgw_csum_idx_valid(cf, res);
> +}
> +
>   static void cgw_csum_xor_rel(struct canfd_frame *cf, struct cgw_csum_xor *xor)
>   {
>   	int from = calc_idx(xor->from_idx, cf->len);
> @@ -326,7 +339,7 @@ static void cgw_csum_xor_rel(struct canfd_frame *cf, struct cgw_csum_xor *xor)
>   	u8 val = xor->init_xor_val;
>   	int i;
>   
> -	if (from < 0 || to < 0 || res < 0)
> +	if (!cgw_csum_range_valid(cf, from, to, res))
>   		return;
>   
>   	if (from <= to) {
> @@ -345,6 +358,10 @@ static void cgw_csum_xor_pos(struct canfd_frame *cf, struct cgw_csum_xor *xor)
>   	u8 val = xor->init_xor_val;
>   	int i;
>   
> +	if (!cgw_csum_range_valid(cf, xor->from_idx, xor->to_idx,
> +				  xor->result_idx))
> +		return;
> +
>   	for (i = xor->from_idx; i <= xor->to_idx; i++)
>   		val ^= cf->data[i];
>   
> @@ -356,6 +373,10 @@ static void cgw_csum_xor_neg(struct canfd_frame *cf, struct cgw_csum_xor *xor)
>   	u8 val = xor->init_xor_val;
>   	int i;
>   
> +	if (!cgw_csum_range_valid(cf, xor->from_idx, xor->to_idx,
> +				  xor->result_idx))
> +		return;
> +
>   	for (i = xor->from_idx; i >= xor->to_idx; i--)
>   		val ^= cf->data[i];
>   
> @@ -371,7 +392,10 @@ static void cgw_csum_crc8_rel(struct canfd_frame *cf,
>   	u8 crc = crc8->init_crc_val;
>   	int i;
>   
> -	if (from < 0 || to < 0 || res < 0)
> +	if (!cgw_csum_range_valid(cf, from, to, res))
> +		return;
> +
> +	if (crc8->profile == CGW_CRC8PRF_16U8 && cf->len < 2)
>   		return;
>   
>   	if (from <= to) {
> @@ -406,6 +430,13 @@ static void cgw_csum_crc8_pos(struct canfd_frame *cf,
>   	u8 crc = crc8->init_crc_val;
>   	int i;
>   
> +	if (!cgw_csum_range_valid(cf, crc8->from_idx, crc8->to_idx,
> +				  crc8->result_idx))
> +		return;
> +
> +	if (crc8->profile == CGW_CRC8PRF_16U8 && cf->len < 2)
> +		return;
> +
>   	for (i = crc8->from_idx; i <= crc8->to_idx; i++)
>   		crc = crc8->crctab[crc ^ cf->data[i]];
>   
> @@ -433,6 +464,13 @@ static void cgw_csum_crc8_neg(struct canfd_frame *cf,
>   	u8 crc = crc8->init_crc_val;
>   	int i;
>   
> +	if (!cgw_csum_range_valid(cf, crc8->from_idx, crc8->to_idx,
> +				  crc8->result_idx))
> +		return;
> +
> +	if (crc8->profile == CGW_CRC8PRF_16U8 && cf->len < 2)
> +		return;
> +
>   	for (i = crc8->from_idx; i >= crc8->to_idx; i--)
>   		crc = crc8->crctab[crc ^ cf->data[i]];
>   
> 


