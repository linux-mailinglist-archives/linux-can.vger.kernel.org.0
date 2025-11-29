Return-Path: <linux-can+bounces-5787-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73687C945A4
	for <lists+linux-can@lfdr.de>; Sat, 29 Nov 2025 18:29:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5CFC3A7095
	for <lists+linux-can@lfdr.de>; Sat, 29 Nov 2025 17:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A4F23ABB0;
	Sat, 29 Nov 2025 17:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="hU9PvvRp";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="dk/kO+t+"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0369475;
	Sat, 29 Nov 2025 17:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764437388; cv=pass; b=cz95iM3lo1bTiZvKO5PZbneVeaQtBorgorxfhBYepL8rDLGDicceLY6kE/KcvVFMA9X9CcpT6JnaBA4X83fTH/J/dsAzyTE5Qe7VI2KEsravxAvE8rcqfOAAmYxp8RFOZe/j54qxO0S+UkczFETK0S2HQt5appUnOmCGwvL5fLI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764437388; c=relaxed/simple;
	bh=JZ8CJNPvx/caXdRDq7CPDyh0m/0LDrUFJACq3tjFQ64=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UcJ9jlhbf5/L+TVzp/3/JxDXHhPOPsdWUWNQ91N9Z0+aQ8K1QBcFR00mteMEyZ0owvay4LRQuHJ9IgxtVnFWVotO8TohKO/Gfyn7/CLQUSwPzF/8xX9kodG9hnQYZFVkngkCEonEmMJN2npZl7hYjV7JOat0EsI/qT+EVHyew+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=hU9PvvRp; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=dk/kO+t+; arc=pass smtp.client-ip=85.215.255.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1764437201; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Pz9S1CKJUThcTnWwo5aTeHF/st3/j+IFWHfCDy6+yOmg92phd+STfG86/LFisiA5Uy
    n+P4EwiO+4Wb35bnt1sPdsHJHqSfZ3OdN+yXxryN6Pi66cra1nPxUJMuRd6ZcaQ6HQYu
    8QLZUr3ABFJDfslFoFn+kX/FsECI9Ly4xhyRut/vm+b/08Bpy6Vpbe+/kXfKx896rWpU
    yP+hO3qQV8p0HOrdzRaPyJM9QXIyB5OSJijJS4IMsPllVcJj6pQ94FMTJxDEA91uAWec
    Y1bWk4t5SrvuDwgr7Z0ZpCfF+2OE5Cyzenq+zSxR2qf9seXGVIa3UuoAmxYxez+ffT21
    xKzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1764437201;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=si4AeCtWOXkoOyuvWpdAYpmdJWcY1mDVpLUzx3cvI4w=;
    b=m/e8CapNU0shBEUTe9shfWDX+L+QfK+583vTBZqmmjavpUos0DIeShzARteCHk/aVk
    HrA4GKJ3qzr1lfeuZ03j2pvvmRaMlXuphR0n9OzIwji5eETw97/LSZ+D12j9PdPJs2/+
    r4g9v5Prhn01gfWMFZ+MGuQHUjoJvt0DdXa1gRy09KicSXpc5qgj4PiBW3oK9BNhJz0z
    Y17QbxeCQmJ5oSNkbioSgsxIuKmkpAvepjhizmZ/Zh994SIOzcyOBhLCm71nUqYhcyyr
    Vh8yg8nlBGjRh3xCN6zjwXJJSt6Wj9BCXbZ7KWzO81/XqD8Cik5lOgZsyBgZ/Dt2FADk
    Ze+Q==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1764437201;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=si4AeCtWOXkoOyuvWpdAYpmdJWcY1mDVpLUzx3cvI4w=;
    b=hU9PvvRpO+AHW9iCKITqWUnKv7LsN/rC3YLGJqJeDMrhki/iLYs32bR6hNQvo7Qk5k
    SGxTeLj94dzBoxfL39BTnCK7gTYa4vJBuuKCXQuhipIKdHO4gxW9Loj9SOqWuJWQj86U
    LHOt1Dp63jytZjjf7Df1FHD0ILtrbW9l7b5qCrlDf4uJNz1ZCN5nvHtCG83y0/bLH3bd
    9EyCBUCpfk3kF61kZm/RdsU0M8HP1zk6TLyXdB3xhWuUFJ+UYdfNPFKWSSwvsq5jY/Mw
    oY/r2BApuTK3A6xqrmOUZ9h+p1e0c9VzNgWeBqp45nzhe4zY4lcWbawiGO9N62zkzQf5
    HEuA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1764437201;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=si4AeCtWOXkoOyuvWpdAYpmdJWcY1mDVpLUzx3cvI4w=;
    b=dk/kO+t+qs6nGQ2nRJlEr6g76P254UL/4ntotiOKFZCKkDbaycJjMyyLUWC8+6JI/2
    wU9Jmd9ANxIbm/grPbBw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::9f3]
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461ATHQfk0x
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 29 Nov 2025 18:26:41 +0100 (CET)
Message-ID: <5858d7d4-cee4-4838-94bd-b5bab8fb32b0@hartkopp.net>
Date: Sat, 29 Nov 2025 18:26:41 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] iplink_can: add CAN XL's PWM interface
To: Vincent Mailhol <mailhol@kernel.org>, netdev@vger.kernel.org,
 Stephen Hemminger <stephen@networkplumber.org>,
 Marc Kleine-Budde <mkl@pengutronix.de>, David Ahern <dsahern@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-can@vger.kernel.org
References: <20251129-canxl-netlink-v1-0-96f2c0c54011@kernel.org>
 <20251129-canxl-netlink-v1-7-96f2c0c54011@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20251129-canxl-netlink-v1-7-96f2c0c54011@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 29.11.25 16:29, Vincent Mailhol wrote:
> This is the iproute2 counterpart of Linux kernel's commit 46552323fa67
> ("can: netlink: add PWM netlink interface").
> 
> When the TMS is switched on, the node uses PWM (Pulse Width Modulation)
> during the data phase instead of the classic NRZ (Non Return to Zero)
> encoding.
> 
> PWM is configured by three parameters:
> 
>    - PWMS: Pulse Width Modulation Short phase
>    - PWML: Pulse Width Modulation Long phase
>    - PWMO: Pulse Width Modulation Offset time
> 
> For each of these parameters, the CAN netlink interface defines three IFLA
> symbols:
> 
>    - IFLA_CAN_PWM_PWM*_MIN: the minimum allowed value.
>    - IFLA_CAN_PWM_PWM*_MAX: the maximum allowed value.
>    - IFLA_CAN_PWM_PWM*: the runtime value.
> 
> This results in a total of nine IFLA symbols which are all nested in a
> parent IFLA_CAN_XL_PWM symbol.
> 
> Add the "pwms", "pwml" and "pwmo" options to iplink_can which controls the
> IFLA_CAN_PWM_PWM* runtime values.
> 
> Add the logic to query and print all those IFLA values. Update
> print_usage() accordingly.
> 
> Example using the dummy_can driver:
> 
>    #  modprobe dummy_can
       ^^ two spaces

>    # ip link set can0 type can bitrate 1000000 xl on xbitrate 20000000 tms on
>    $ ip --details link show can0
>    5: can0: <NOARP> mtu 2060 qdisc noop state DOWN mode DEFAULT group default qlen 10
>        link/can  promiscuity 0 allmulti 0 minmtu 76 maxmtu 2060
>        can <XL,XL-TMS> state STOPPED restart-ms 0
              <XL,TMS>

Best regards,
Oliver

>    	  bitrate 1000000 sample-point 0.750
>    	  tq 6 prop-seg 59 phase-seg1 60 phase-seg2 40 sjw 20 brp 1
>    	  dummy_can CC: tseg1 2..256 tseg2 2..128 sjw 1..128 brp 1..512 brp_inc 1
>    	  dummy_can FD: dtseg1 2..256 dtseg2 2..128 dsjw 1..128 dbrp 1..512 dbrp_inc 1
>    	  tdco 0..127 tdcf 0..127
>    	  xbitrate 20000000 xsample-point 0.625
>    	  xtq 6 xprop-seg 2 xphase-seg1 2 xphase-seg2 3 xsjw 1 xbrp 1
>    	  pwms 2 pwml 6 pwmo 0
>    	  dummy_can XL: xtseg1 2..256 xtseg2 2..128 xsjw 1..128 xbrp 1..512 xbrp_inc 1
>    	  xtdco 0..127 xtdcf 0..127
>    	  pwms 1..8 pwml 2..24 pwmo 0..16
>    	  clock 160000000 numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_max_segs 65535 tso_max_size 65536 tso_max_segs 65535 gro_max_size 65536 gso_ipv4_max_size 65536 gro_ipv4_max_size 65536
> 
> Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
> ---
>   ip/iplink_can.c | 92 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 91 insertions(+), 1 deletion(-)
> 
> diff --git a/ip/iplink_can.c b/ip/iplink_can.c
> index 3e7925e8..d43dc9bb 100644
> --- a/ip/iplink_can.c
> +++ b/ip/iplink_can.c
> @@ -34,7 +34,7 @@ static void print_usage(FILE *f)
>   		"\n"
>   		"\t[ xbitrate BITRATE [ xsample-point SAMPLE-POINT] ] |\n"
>   		"\t[ xtq TQ xprop-seg PROP_SEG xphase-seg1 PHASE-SEG1\n \t  xphase-seg2 PHASE-SEG2 [ xsjw SJW ] ]\n"
> -		"\t[ xtdcv TDCV xtdco TDCO xtdcf TDCF ]\n"
> +		"\t[ xtdcv TDCV xtdco TDCO xtdcf TDCF pwms PWMS pwml PWML pwmo PWMO]\n"
>   		"\n"
>   		"\t[ loopback { on | off } ]\n"
>   		"\t[ listen-only { on | off } ]\n"
> @@ -67,6 +67,9 @@ static void print_usage(FILE *f)
>   		"\t	TDCV		:= { NUMBER in mtq }\n"
>   		"\t	TDCO		:= { NUMBER in mtq }\n"
>   		"\t	TDCF		:= { NUMBER in mtq }\n"
> +		"\t	PWMS		:= { NUMBER in mtq }\n"
> +		"\t	PWML		:= { NUMBER in mtq }\n"
> +		"\t	PWMO		:= { NUMBER in mtq }\n"
>   		"\t	RESTART-MS	:= { 0 | NUMBER in ms }\n"
>   		"\n"
>   		"\tUnits:\n"
> @@ -143,6 +146,7 @@ static int can_parse_opt(struct link_util *lu, int argc, char **argv,
>   	struct can_ctrlmode cm = { 0 };
>   	struct can_tdc fd = { .tdcv = -1, .tdco = -1, .tdcf = -1 };
>   	struct can_tdc xl = { .tdcv = -1, .tdco = -1, .tdcf = -1 };
> +	__u32 pwms = -1, pwml = -1, pwmo = -1;
>   
>   	while (argc > 0) {
>   		if (matches(*argv, "bitrate") == 0) {
> @@ -266,6 +270,18 @@ static int can_parse_opt(struct link_util *lu, int argc, char **argv,
>   			NEXT_ARG();
>   			if (get_u32(&xl.tdcf, *argv, 0))
>   				invarg("invalid \"xtdcf\" value", *argv);
> +		} else if (matches(*argv, "pwms") == 0) {
> +			NEXT_ARG();
> +			if (get_u32(&pwms, *argv, 0))
> +				invarg("invalid \"pwms\" value", *argv);
> +		} else if (matches(*argv, "pwml") == 0) {
> +			NEXT_ARG();
> +			if (get_u32(&pwml, *argv, 0))
> +				invarg("invalid \"pwml\" value", *argv);
> +		} else if (matches(*argv, "pwmo") == 0) {
> +			NEXT_ARG();
> +			if (get_u32(&pwmo, *argv, 0))
> +				invarg("invalid \"pwmo\" value", *argv);
>   		} else if (matches(*argv, "loopback") == 0) {
>   			NEXT_ARG();
>   			set_ctrlmode("loopback", *argv, &cm,
> @@ -401,6 +417,18 @@ static int can_parse_opt(struct link_util *lu, int argc, char **argv,
>   			addattr32(n, 1024, IFLA_CAN_TDC_TDCF, xl.tdcf);
>   		addattr_nest_end(n, tdc);
>   	}
> +	if (pwms != -1 || pwml != -1 || pwmo != -1) {
> +		struct rtattr *pwm = addattr_nest(n, 1024,
> +						  IFLA_CAN_XL_PWM | NLA_F_NESTED);
> +
> +		if (pwms != -1)
> +			addattr32(n, 1024, IFLA_CAN_PWM_PWMS, pwms);
> +		if (pwml != -1)
> +			addattr32(n, 1024, IFLA_CAN_PWM_PWML, pwml);
> +		if (pwmo != -1)
> +			addattr32(n, 1024, IFLA_CAN_PWM_PWMO, pwmo);
> +		addattr_nest_end(n, pwm);
> +	}
>   
>   	return 0;
>   }
> @@ -496,6 +524,62 @@ static void can_print_tdc_const_opt(struct rtattr *tdc_attr, bool is_xl)
>   	close_json_object();
>   }
>   
> +static void can_print_pwm_opt(struct rtattr *pwm_attr)
> +{
> +	struct rtattr *tb[IFLA_CAN_PWM_MAX + 1];
> +
> +	parse_rtattr_nested(tb, IFLA_CAN_PWM_MAX, pwm_attr);
> +	if (tb[IFLA_CAN_PWM_PWMS] || tb[IFLA_CAN_PWM_PWML] ||
> +	    tb[IFLA_CAN_PWM_PWMO]) {
> +		open_json_object("pwm");
> +		can_print_nl_indent();
> +		if (tb[IFLA_CAN_PWM_PWMS]) {
> +			__u32 *pwms = RTA_DATA(tb[IFLA_CAN_PWM_PWMS]);
> +
> +			print_uint(PRINT_ANY, " pwms", " pwms %u", *pwms);
> +		}
> +		if (tb[IFLA_CAN_PWM_PWML]) {
> +			__u32 *pwml = RTA_DATA(tb[IFLA_CAN_PWM_PWML]);
> +
> +			print_uint(PRINT_ANY, " pwml", " pwml %u", *pwml);
> +		}
> +		if (tb[IFLA_CAN_PWM_PWMO]) {
> +			__u32 *pwmo = RTA_DATA(tb[IFLA_CAN_PWM_PWMO]);
> +
> +			print_uint(PRINT_ANY, " pwmo", " pwmo %u", *pwmo);
> +		}
> +		close_json_object();
> +	}
> +}
> +
> +static void can_print_pwm_const_opt(struct rtattr *pwm_attr)
> +{
> +	struct rtattr *tb[IFLA_CAN_PWM_MAX + 1];
> +
> +	parse_rtattr_nested(tb, IFLA_CAN_PWM_MAX, pwm_attr);
> +	open_json_object("pwm");
> +	can_print_nl_indent();
> +	if (tb[IFLA_CAN_PWM_PWMS_MAX]) {
> +		__u32 *pwms_min = RTA_DATA(tb[IFLA_CAN_PWM_PWMS_MIN]);
> +		__u32 *pwms_max = RTA_DATA(tb[IFLA_CAN_PWM_PWMS_MAX]);
> +
> +		can_print_timing_min_max("pwms", " pwms", *pwms_min, *pwms_max);
> +	}
> +	if (tb[IFLA_CAN_PWM_PWML_MAX]) {
> +		__u32 *pwml_min = RTA_DATA(tb[IFLA_CAN_PWM_PWML_MIN]);
> +		__u32 *pwml_max = RTA_DATA(tb[IFLA_CAN_PWM_PWML_MAX]);
> +
> +		can_print_timing_min_max("pwml", " pwml", *pwml_min, *pwml_max);
> +	}
> +	if (tb[IFLA_CAN_PWM_PWMO_MAX]) {
> +		__u32 *pwmo_min = RTA_DATA(tb[IFLA_CAN_PWM_PWMO_MIN]);
> +		__u32 *pwmo_max = RTA_DATA(tb[IFLA_CAN_PWM_PWMO_MAX]);
> +
> +		can_print_timing_min_max("pwmo", " pwmo", *pwmo_min, *pwmo_max);
> +	}
> +	close_json_object();
> +}
> +
>   static void can_print_ctrlmode_ext(struct rtattr *ctrlmode_ext_attr,
>   				   __u32 cm_flags)
>   {
> @@ -735,6 +819,9 @@ static void can_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
>   		if (tb[IFLA_CAN_XL_TDC])
>   			can_print_tdc_opt(tb[IFLA_CAN_XL_TDC], true);
>   
> +		if (tb[IFLA_CAN_XL_PWM])
> +			can_print_pwm_opt(tb[IFLA_CAN_XL_PWM]);
> +
>   		close_json_object();
>   	}
>   
> @@ -759,6 +846,9 @@ static void can_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
>   		if (tb[IFLA_CAN_XL_TDC])
>   			can_print_tdc_const_opt(tb[IFLA_CAN_XL_TDC], true);
>   
> +		if (tb[IFLA_CAN_XL_PWM])
> +			can_print_pwm_const_opt(tb[IFLA_CAN_XL_PWM]);
> +
>   		close_json_object();
>   	}
>   
> 


