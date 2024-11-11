Return-Path: <linux-can+bounces-1956-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7ED9C40B9
	for <lists+linux-can@lfdr.de>; Mon, 11 Nov 2024 15:19:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C30E51C219F5
	for <lists+linux-can@lfdr.de>; Mon, 11 Nov 2024 14:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233FA19F128;
	Mon, 11 Nov 2024 14:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="LlW60PMf";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="ah4kb9Gc"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5264199939
	for <linux-can@vger.kernel.org>; Mon, 11 Nov 2024 14:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.167
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731334758; cv=pass; b=VduSbNEyyjSdSCS/qlkqInbpRY0q7P4xDE7zjD9DSiRJIVUdTL3T2Q8J+eDvxKU1b9ANs2Ga6JtJVoLlYEUa0Au52MWd5Xy9roqQae9XLkO/6cuPLr+iYPJSPQdmVp+AUKkwrrRkdyLQYgw3fkQnYi+szuXDpnQVGfbo1amGwuo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731334758; c=relaxed/simple;
	bh=OFHEcDTrtmjb5Cmojpc7nRkb2/0V/C2V2/o2OJs5y6Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XlrgCTjKuhEKb6Qx2JjoE1GxWRl2T0aJpsrP3KveCFt/2OptDQmKw4M+0aZeJbu7igAE78Ow7jzNQncACYIed2GHuEbQAVWUYqs9KU7w2fV4dnlY98Ib3KhK4LZj1WRZasQ8SNfLCOoZjn2lFcU/xtojauwlgK9dsSbG+y42qR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=LlW60PMf; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=ah4kb9Gc; arc=pass smtp.client-ip=81.169.146.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1731334381; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=PuJ/prwDKbIzWvWbcDDNTEUygfUh7VJhRW9a/76g5vOh/j7jCh9LOTGQmrQN+oh2jl
    V97WeZj8Mue56MyYDy6Cwt+ijaPyJaO04X9YOZ5duj3LOnBKopSioxLM0/azC4NnBcsN
    QlYA6gspbkWL86eqPd1RVA/thwuz3YYyu+bU5HjFevHJ99pF4EbWLnyTiq7NP4wmJfLx
    KPwx4o9gfKUl+StAchHPByGzJWEidXyrJVyioNU0l5Tn0tmeeRjSvtoeGedkNK1AoDcq
    JUz5lGUm+ta9TOB71rUm8SqRtdCE+MxB999QZjhvQ9MMuc0tDo82rJGTvkObxmYcXxN+
    PJrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1731334381;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=FqyQwwCYgLgjdRmOkGkWgCKCGIQ/Ftcj+l1VR1rO9Dw=;
    b=dg893wO7wBmPGOVa/wfeFaIgUnOXgyI0AnMCM98A7CKtfs9+Uyve7XmCKNRpMjY3UB
    MpLyYzpG+QOsqlQvwZu9hYcJ6k0JQvcJMYtuhAIqFBopE3MjgzerT3Iwa6czyUy+X79T
    SJQCeLApHb7Fo1fqPaUwsXRklGXlwRsSjvb6XOnrxr0yNla5nEbHbk/x4qshUfXMWD1P
    KJPUqbWq5lVMTfCU61fMv5lqwJNNRsJWqcuxkY5L5zfOcinDG17MxlbrH3CCnH1HGfDQ
    +wH3CAOq61pLwRMel+VrkIv7OZTaX7dxN+AtKyAQU9T/VT0/VVziQUcUyMw/43/6/N+Q
    s+iA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1731334381;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=FqyQwwCYgLgjdRmOkGkWgCKCGIQ/Ftcj+l1VR1rO9Dw=;
    b=LlW60PMf5jwPzhFcDfnzxwA7tNhYC4SRz9LNQZgNACs4Hr7bamek8AdcH6G0c+Tu83
    FeebZo9oCgk9ABpSV/Iijm4NGBMb0kELdCXuhG+e5UGfEFoJhYoYhmD2wcgijXE8dnnV
    gOgXKJffMYXdb4ilegwYUnBnTDQouddQGyj19RwcqYUvdp9FPHHYu2pixiwE6LYJSkim
    wUz2LErl9rSUxoYtUNhbz443cTD1GBB77CvplWt0efrq9uGzFcVMJpH8yL5uYTnVjIwG
    cKfZ8KOLz0E0chaZKvkxAJnHIuNF3+sK7nekF13wTwPvwavJScPornpKiB+rXqd5bMct
    MQXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1731334381;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=FqyQwwCYgLgjdRmOkGkWgCKCGIQ/Ftcj+l1VR1rO9Dw=;
    b=ah4kb9Gc7Rb8tzptBrng5It93tS5FRG118PWG1FmWPMJOF6+G9ln+9MiCZarAISUAd
    WUBl9DWlBPqE7I92KjBA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/vMMcFB+5xtv9aJ67XA=="
Received: from [IPV6:2a00:6020:4a8e:5000::9f3]
    by smtp.strato.de (RZmta 51.2.11 AUTH)
    with ESMTPSA id K63ada0ABED1800
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 11 Nov 2024 15:13:01 +0100 (CET)
Message-ID: <ff161f8d-6302-47b1-984d-8964eb75fc9f@hartkopp.net>
Date: Mon, 11 Nov 2024 15:13:01 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 8/8] iplink_can: add CAN XL
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, linux-can@vger.kernel.org,
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Robert Nawrath <mbro1689@gmail.com>
References: <20241110160406.73584-10-mailhol.vincent@wanadoo.fr>
 <20241110160406.73584-18-mailhol.vincent@wanadoo.fr>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20241110160406.73584-18-mailhol.vincent@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10.11.24 17:01, Vincent Mailhol wrote:
> Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> ---
>   ip/iplink_can.c | 209 +++++++++++++++++++++++++++++++++++++++++++++---
>   1 file changed, 196 insertions(+), 13 deletions(-)
> 
> diff --git a/ip/iplink_can.c b/ip/iplink_can.c
> index 54acc65c..43018c54 100644
> --- a/ip/iplink_can.c
> +++ b/ip/iplink_can.c
> @@ -26,6 +26,10 @@ static void print_usage(FILE *f)
>   		"\t[ dtq TQ dprop-seg PROP_SEG dphase-seg1 PHASE-SEG1\n \t  dphase-seg2 PHASE-SEG2 [ dsjw SJW ] ]\n"
>   		"\t[ tdcv TDCV tdco TDCO tdcf TDCF ]\n"
>   		"\n"
> +		"\t[ xl-dbitrate BITRATE [ xl-dsample-point SAMPLE-POINT] ] |\n"
> +		"\t[ xl-dtq TQ xl-dprop-seg PROP_SEG xl-dphase-seg1 PHASE-SEG1\n \t  xl-dphase-seg2 PHASE-SEG2 [ xl-dsjw SJW ] ]\n"
> +		"\t[ xl-tdcv TDCV xl-tdco TDCO xl-tdcf TDCF ]\n"

s/xl-d/x/ ?

xsample-point seems more handy than xl-dsample-point

Best regards,
Oliver

> +		"\n"
>   		"\t[ loopback { on | off } ]\n"
>   		"\t[ listen-only { on | off } ]\n"
>   		"\t[ triple-sampling { on | off } ]\n"
> @@ -36,6 +40,8 @@ static void print_usage(FILE *f)
>   		"\t[ presume-ack { on | off } ]\n"
>   		"\t[ cc-len8-dlc { on | off } ]\n"
>   		"\t[ tdc-mode { auto | manual | off } ]\n"
> +		"\t[ xl { on | off } ]\n"
> +		"\t[ xl-tdc-mode { auto | manual | off } ]\n"
>   		"\n"
>   		"\t[ restart-ms TIME-MS ]\n"
>   		"\t[ restart ]\n"
> @@ -116,6 +122,9 @@ static void print_ctrlmode(enum output_type t, __u32 flags, const char* key)
>   	print_flag(t, &flags, CAN_CTRLMODE_CC_LEN8_DLC, "CC-LEN8-DLC");
>   	print_flag(t, &flags, CAN_CTRLMODE_TDC_AUTO, "TDC-AUTO");
>   	print_flag(t, &flags, CAN_CTRLMODE_TDC_MANUAL, "TDC-MANUAL");
> +	print_flag(t, &flags, CAN_CTRLMODE_XL, "XL");
> +	print_flag(t, &flags, CAN_CTRLMODE_XL_TDC_AUTO, "XL-TDC-AUTO");
> +	print_flag(t, &flags, CAN_CTRLMODE_XL_TDC_MANUAL, "XL-TDC-MANUAL");
>   
>   	if (flags)
>   		print_hex(t, NULL, "%x", flags);
> @@ -132,9 +141,10 @@ struct can_tdc {
>   static int can_parse_opt(struct link_util *lu, int argc, char **argv,
>   			 struct nlmsghdr *n)
>   {
> -	struct can_bittiming bt = {}, fd_dbt = {};
> +	struct can_bittiming bt = {}, fd_dbt = {}, xl_dbt = {};
>   	struct can_ctrlmode cm = { 0 };
>   	struct can_tdc fd = { .tdcv = -1, .tdco = -1, .tdcf = -1 };
> +	struct can_tdc xl = { .tdcv = -1, .tdco = -1, .tdcf = -1 };
>   
>   	while (argc > 0) {
>   		if (matches(*argv, "bitrate") == 0) {
> @@ -212,6 +222,53 @@ static int can_parse_opt(struct link_util *lu, int argc, char **argv,
>   			NEXT_ARG();
>   			if (get_u32(&fd.tdcf, *argv, 0))
>   				invarg("invalid \"tdcf\" value", *argv);
> +		} else if (matches(*argv, "xl") == 0) {
> +			NEXT_ARG();
> +			set_ctrlmode("xl", *argv, &cm,
> +				     CAN_CTRLMODE_XL);
> +		} else if (matches(*argv, "xl-dbitrate") == 0) {
> +			NEXT_ARG();
> +			if (get_u32(&xl_dbt.bitrate, *argv, 0))
> +				invarg("invalid \"xl-dbitrate\" value", *argv);
> +		} else if (matches(*argv, "xl-dsample-point") == 0) {
> +			float sp;
> +
> +			NEXT_ARG();
> +			if (get_float(&sp, *argv))
> +				invarg("invalid \"xl-dsample-point\" value", *argv);
> +			xl_dbt.sample_point = (__u32)(sp * 1000);
> +		} else if (matches(*argv, "xl-dtq") == 0) {
> +			NEXT_ARG();
> +			if (get_u32(&xl_dbt.tq, *argv, 0))
> +				invarg("invalid \"xl-dtq\" value", *argv);
> +		} else if (matches(*argv, "xl-dprop-seg") == 0) {
> +			NEXT_ARG();
> +			if (get_u32(&xl_dbt.prop_seg, *argv, 0))
> +				invarg("invalid \"xl-dprop-seg\" value", *argv);
> +		} else if (matches(*argv, "xl-dphase-seg1") == 0) {
> +			NEXT_ARG();
> +			if (get_u32(&xl_dbt.phase_seg1, *argv, 0))
> +				invarg("invalid \"xl-dphase-seg1\" value", *argv);
> +		} else if (matches(*argv, "xl-dphase-seg2") == 0) {
> +			NEXT_ARG();
> +			if (get_u32(&xl_dbt.phase_seg2, *argv, 0))
> +				invarg("invalid \"xl-dphase-seg2\" value", *argv);
> +		} else if (matches(*argv, "xl-dsjw") == 0) {
> +			NEXT_ARG();
> +			if (get_u32(&xl_dbt.sjw, *argv, 0))
> +				invarg("invalid \"xl-dsjw\" value", *argv);
> +		} else if (matches(*argv, "xl-tdcv") == 0) {
> +			NEXT_ARG();
> +			if (get_u32(&xl.tdcv, *argv, 0))
> +				invarg("invalid \"xl-tdcv\" value", *argv);
> +		} else if (matches(*argv, "xl-tdco") == 0) {
> +			NEXT_ARG();
> +			if (get_u32(&xl.tdco, *argv, 0))
> +				invarg("invalid \"xl-tdco\" value", *argv);
> +		} else if (matches(*argv, "xl-tdcf") == 0) {
> +			NEXT_ARG();
> +			if (get_u32(&xl.tdcf, *argv, 0))
> +				invarg("invalid \"xl-tdcf\" value", *argv);
>   		} else if (matches(*argv, "loopback") == 0) {
>   			NEXT_ARG();
>   			set_ctrlmode("loopback", *argv, &cm,
> @@ -263,6 +320,21 @@ static int can_parse_opt(struct link_util *lu, int argc, char **argv,
>   				invarg("\"tdc-mode\" must be either of \"auto\", \"manual\" or \"off\"",
>   					*argv);
>   			}
> +		} else if (matches(*argv, "xl-tdc-mode") == 0) {
> +			NEXT_ARG();
> +			if (strcmp(*argv, "auto") == 0) {
> +				cm.flags |= CAN_CTRLMODE_XL_TDC_AUTO;
> +				cm.mask |= CAN_CTRLMODE_XL_TDC_AUTO;
> +			} else if (strcmp(*argv, "manual") == 0) {
> +				cm.flags |= CAN_CTRLMODE_XL_TDC_MANUAL;
> +				cm.mask |= CAN_CTRLMODE_XL_TDC_MANUAL;
> +			} else if (strcmp(*argv, "off") == 0) {
> +				cm.mask |= CAN_CTRLMODE_XL_TDC_AUTO |
> +					   CAN_CTRLMODE_XL_TDC_MANUAL;
> +			} else {
> +				invarg("\"xl-tdc-mode\" must be either of \"auto\", \"manual\" or \"off\"",
> +					*argv);
> +			}
>   		} else if (matches(*argv, "restart") == 0) {
>   			__u32 val = 1;
>   
> @@ -297,6 +369,8 @@ static int can_parse_opt(struct link_util *lu, int argc, char **argv,
>   		addattr_l(n, 1024, IFLA_CAN_BITTIMING, &bt, sizeof(bt));
>   	if (fd_dbt.bitrate || fd_dbt.tq)
>   		addattr_l(n, 1024, IFLA_CAN_DATA_BITTIMING, &fd_dbt, sizeof(fd_dbt));
> +	if (xl_dbt.bitrate || xl_dbt.tq)
> +		addattr_l(n, 1024, IFLA_CAN_XL_DATA_BITTIMING, &xl_dbt, sizeof(xl_dbt));
>   	if (cm.mask)
>   		addattr_l(n, 1024, IFLA_CAN_CTRLMODE, &cm, sizeof(cm));
>   
> @@ -312,6 +386,18 @@ static int can_parse_opt(struct link_util *lu, int argc, char **argv,
>   			addattr32(n, 1024, IFLA_CAN_TDC_TDCF, fd.tdcf);
>   		addattr_nest_end(n, tdc);
>   	}
> +	if (xl.tdcv != -1 || xl.tdco != -1 || xl.tdcf != -1) {
> +		struct rtattr *tdc = addattr_nest(n, 1024,
> +						  IFLA_CAN_XL_TDC | NLA_F_NESTED);
> +
> +		if (xl.tdcv != -1)
> +			addattr32(n, 1024, IFLA_CAN_TDC_TDCV, xl.tdcv);
> +		if (xl.tdco != -1)
> +			addattr32(n, 1024, IFLA_CAN_TDC_TDCO, xl.tdco);
> +		if (xl.tdcf != -1)
> +			addattr32(n, 1024, IFLA_CAN_TDC_TDCF, xl.tdcf);
> +		addattr_nest_end(n, tdc);
> +	}
>   
>   	return 0;
>   }
> @@ -342,58 +428,67 @@ can_print_timing_min_max(const char *json_attr, const char *fp_attr,
>   	close_json_object();
>   }
>   
> -static void can_print_tdc_opt(struct rtattr *tdc_attr)
> +static void can_print_tdc_opt(struct rtattr *tdc_attr, bool is_xl)
>   {
>   	struct rtattr *tb[IFLA_CAN_TDC_MAX + 1];
>   
>   	parse_rtattr_nested(tb, IFLA_CAN_TDC_MAX, tdc_attr);
>   	if (tb[IFLA_CAN_TDC_TDCV] || tb[IFLA_CAN_TDC_TDCO] ||
>   	    tb[IFLA_CAN_TDC_TDCF]) {
> -		open_json_object("tdc");
> +		const char *tdc = is_xl ? "xl-tdc" : "tdc";
> +
> +		open_json_object(tdc);
>   		can_print_nl_indent();
>   		if (tb[IFLA_CAN_TDC_TDCV]) {
> +			const char *tdcv_fmt = is_xl ? " xl-tdcv %u" : " tdcv %u";
>   			__u32 *tdcv = RTA_DATA(tb[IFLA_CAN_TDC_TDCV]);
>   
> -			print_uint(PRINT_ANY, "tdcv", " tdcv %u", *tdcv);
> +			print_uint(PRINT_ANY, "tdcv", tdcv_fmt, *tdcv);
>   		}
>   		if (tb[IFLA_CAN_TDC_TDCO]) {
> +			const char *tdco_fmt = is_xl ? " xl-tdco %u" : " tdco %u";
>   			__u32 *tdco = RTA_DATA(tb[IFLA_CAN_TDC_TDCO]);
>   
> -			print_uint(PRINT_ANY, "tdco", " tdco %u", *tdco);
> +			print_uint(PRINT_ANY, "tdco", tdco_fmt, *tdco);
>   		}
>   		if (tb[IFLA_CAN_TDC_TDCF]) {
> +			const char *tdcf_fmt = is_xl ? " xl-tdcf %u" : " tdcf %u";
>   			__u32 *tdcf = RTA_DATA(tb[IFLA_CAN_TDC_TDCF]);
>   
> -			print_uint(PRINT_ANY, "tdcf", " tdcf %u", *tdcf);
> +			print_uint(PRINT_ANY, "tdcf", tdcf_fmt, *tdcf);
>   		}
>   		close_json_object();
>   	}
>   }
>   
> -static void can_print_tdc_const_opt(struct rtattr *tdc_attr)
> +static void can_print_tdc_const_opt(struct rtattr *tdc_attr, bool is_xl)
>   {
> +	const char *tdc = is_xl ? "xl-tdc" : "tdc";
>   	struct rtattr *tb[IFLA_CAN_TDC_MAX + 1];
>   
>   	parse_rtattr_nested(tb, IFLA_CAN_TDC_MAX, tdc_attr);
> -	open_json_object("tdc");
> +	open_json_object(tdc);
>   	can_print_nl_indent();
>   	if (tb[IFLA_CAN_TDC_TDCV_MIN] && tb[IFLA_CAN_TDC_TDCV_MAX]) {
>   		__u32 *tdcv_min = RTA_DATA(tb[IFLA_CAN_TDC_TDCV_MIN]);
>   		__u32 *tdcv_max = RTA_DATA(tb[IFLA_CAN_TDC_TDCV_MAX]);
> +		const char *tdcv = is_xl ? " xl-tdcv" : " tdcv";
>   
> -		can_print_timing_min_max("tdcv", " tdcv", *tdcv_min, *tdcv_max);
> +		can_print_timing_min_max("tdcv", tdcv, *tdcv_min, *tdcv_max);
>   	}
>   	if (tb[IFLA_CAN_TDC_TDCO_MIN] && tb[IFLA_CAN_TDC_TDCO_MAX]) {
>   		__u32 *tdco_min = RTA_DATA(tb[IFLA_CAN_TDC_TDCO_MIN]);
>   		__u32 *tdco_max = RTA_DATA(tb[IFLA_CAN_TDC_TDCO_MAX]);
> +		const char *tdco = is_xl ? " xl-tdco" : " tdco";
>   
> -		can_print_timing_min_max("tdco", " tdco", *tdco_min, *tdco_max);
> +		can_print_timing_min_max("tdco", tdco, *tdco_min, *tdco_max);
>   	}
>   	if (tb[IFLA_CAN_TDC_TDCF_MIN] && tb[IFLA_CAN_TDC_TDCF_MAX]) {
>   		__u32 *tdcf_min = RTA_DATA(tb[IFLA_CAN_TDC_TDCF_MIN]);
>   		__u32 *tdcf_max = RTA_DATA(tb[IFLA_CAN_TDC_TDCF_MAX]);
> +		const char *tdcf = is_xl ? " xl-tdcf" : " tdcf";
>   
> -		can_print_timing_min_max("tdcf", " tdcf", *tdcf_min, *tdcf_max);
> +		can_print_timing_min_max("tdcf", tdcf, *tdcf_min, *tdcf_max);
>   	}
>   	close_json_object();
>   }
> @@ -547,7 +642,7 @@ static void can_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
>   		print_uint(PRINT_ANY, "brp", " dbrp %u", dbt->brp);
>   
>   		if (tb[IFLA_CAN_TDC])
> -			can_print_tdc_opt(tb[IFLA_CAN_TDC]);
> +			can_print_tdc_opt(tb[IFLA_CAN_TDC], false);
>   
>   		close_json_object();
>   	}
> @@ -571,7 +666,7 @@ static void can_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
>   		print_uint(PRINT_ANY, "brp_inc", " dbrp_inc %u", dbtc->brp_inc);
>   
>   		if (tb[IFLA_CAN_TDC])
> -			can_print_tdc_const_opt(tb[IFLA_CAN_TDC]);
> +			can_print_tdc_const_opt(tb[IFLA_CAN_TDC], false);
>   
>   		close_json_object();
>   	}
> @@ -610,6 +705,94 @@ static void can_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
>   		close_json_array(PRINT_ANY, " ]");
>   	}
>   
> +	/* data bittiming is irrelevant if fixed bitrate is defined */
> +	if (tb[IFLA_CAN_XL_DATA_BITTIMING] &&
> +	    !tb[IFLA_CAN_XL_DATA_BITRATE_CONST]) {
> +		struct can_bittiming *dbt =
> +			RTA_DATA(tb[IFLA_CAN_XL_DATA_BITTIMING]);
> +		char dsp[6];
> +
> +		open_json_object("xl_data_bittiming");
> +		can_print_nl_indent();
> +		print_uint(PRINT_ANY, "bitrate", " xl-dbitrate %u", dbt->bitrate);
> +		snprintf(dsp, sizeof(dsp), "%.3f", dbt->sample_point / 1000.);
> +		print_string(PRINT_ANY, "sample_point", " xl-dsample-point %s",
> +			     dsp);
> +		can_print_nl_indent();
> +		print_uint(PRINT_ANY, "tq", " xl-dtq %u", dbt->tq);
> +		print_uint(PRINT_ANY, "prop_seg", " xl-dprop-seg %u",
> +			   dbt->prop_seg);
> +		print_uint(PRINT_ANY, "phase_seg1", " xl-dphase-seg1 %u",
> +			   dbt->phase_seg1);
> +		print_uint(PRINT_ANY, "phase_seg2", " xl-dphase-seg2 %u",
> +			   dbt->phase_seg2);
> +		print_uint(PRINT_ANY, "sjw", " xl-dsjw %u", dbt->sjw);
> +		print_uint(PRINT_ANY, "brp", " xl-dbrp %u", dbt->brp);
> +
> +		if (tb[IFLA_CAN_XL_TDC])
> +			can_print_tdc_opt(tb[IFLA_CAN_XL_TDC], true);
> +
> +		close_json_object();
> +	}
> +
> +	/* data bittiming const is irrelevant if fixed bitrate is defined */
> +	if (tb[IFLA_CAN_XL_DATA_BITTIMING_CONST] &&
> +	    !tb[IFLA_CAN_XL_DATA_BITRATE_CONST]) {
> +		struct can_bittiming_const *dbtc =
> +			RTA_DATA(tb[IFLA_CAN_XL_DATA_BITTIMING_CONST]);
> +
> +		open_json_object("xl_data_bittiming_const");
> +		can_print_nl_indent();
> +		print_string(PRINT_ANY, "name", " %s:", dbtc->name);
> +		can_print_timing_min_max("tseg1", " xl-dtseg1",
> +					 dbtc->tseg1_min, dbtc->tseg1_max);
> +		can_print_timing_min_max("tseg2", " xl-dtseg2",
> +					 dbtc->tseg2_min, dbtc->tseg2_max);
> +		can_print_timing_min_max("sjw", " xl-dsjw", 1, dbtc->sjw_max);
> +		can_print_timing_min_max("brp", " xl-dbrp",
> +					 dbtc->brp_min, dbtc->brp_max);
> +		print_uint(PRINT_ANY, "brp_inc", " xl-dbrp_inc %u", dbtc->brp_inc);
> +
> +		if (tb[IFLA_CAN_XL_TDC])
> +			can_print_tdc_const_opt(tb[IFLA_CAN_XL_TDC], true);
> +
> +		close_json_object();
> +	}
> +
> +	if (tb[IFLA_CAN_XL_DATA_BITRATE_CONST]) {
> +		__u32 *dbitrate_const =
> +			RTA_DATA(tb[IFLA_CAN_XL_DATA_BITRATE_CONST]);
> +		int dbitrate_cnt =
> +			RTA_PAYLOAD(tb[IFLA_CAN_XL_DATA_BITRATE_CONST]) /
> +			sizeof(*dbitrate_const);
> +		int i;
> +		__u32 dbitrate = 0;
> +
> +		if (tb[IFLA_CAN_XL_DATA_BITTIMING]) {
> +			struct can_bittiming *dbt =
> +				RTA_DATA(tb[IFLA_CAN_XL_DATA_BITTIMING]);
> +			dbitrate = dbt->bitrate;
> +		}
> +
> +		can_print_nl_indent();
> +		print_uint(PRINT_ANY, "xl_data_bittiming_bitrate", " xl-dbitrate %u",
> +			   dbitrate);
> +		can_print_nl_indent();
> +		open_json_array(PRINT_ANY, is_json_context() ?
> +				"data_bitrate_const" : "    [");
> +		for (i = 0; i < dbitrate_cnt; ++i) {
> +			/* This will keep lines below 80 signs */
> +			if (!(i % 6) && i) {
> +				can_print_nl_indent();
> +				print_string(PRINT_FP, NULL, "%s", "     ");
> +			}
> +			print_uint(PRINT_ANY, NULL,
> +				   i < dbitrate_cnt - 1 ? "%8u, " : "%8u",
> +				   dbitrate_const[i]);
> +		}
> +		close_json_array(PRINT_ANY, " ]");
> +	}
> +
>   	if (tb[IFLA_CAN_TERMINATION_CONST] && tb[IFLA_CAN_TERMINATION]) {
>   		__u16 *trm = RTA_DATA(tb[IFLA_CAN_TERMINATION]);
>   		__u16 *trm_const = RTA_DATA(tb[IFLA_CAN_TERMINATION_CONST]);


