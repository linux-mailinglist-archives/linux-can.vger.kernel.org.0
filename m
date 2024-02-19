Return-Path: <linux-can+bounces-307-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB5885AD09
	for <lists+linux-can@lfdr.de>; Mon, 19 Feb 2024 21:23:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 762221F25EB5
	for <lists+linux-can@lfdr.de>; Mon, 19 Feb 2024 20:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE37252F8C;
	Mon, 19 Feb 2024 20:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="WEn22rq1";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="Z+T0K58g"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9BF52F68;
	Mon, 19 Feb 2024 20:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708374202; cv=pass; b=JeUyBOkiTWU6j6/h32rD8/PFwdx99FhrpJ/9Wk/87PHM6CuntEgrVU5h44HQZ5cb97rgSaqZJ+FEHZKKcNKwuPpz+32Xqz2kjQCktoz9KEGwBlQ4ytA3dzVRJlo8KNcVvSBryJZXzlJO7IID8juBlJn+5ZgcjuLL8uaBd244RQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708374202; c=relaxed/simple;
	bh=ZuhFdCaK+/hgiNviU4bnJ7zFJnr9RLu0hrR9n4lzjH0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uyO90pXMRUQ6NYTuKTB8ZsrflQ1AQnXAAkvscOhZBQrJaCqOyJqDdkAEAOk7rMyEEUcOmYf+oLuRuA96wTQpXeH5jL9EMbDfcAHz/fHDrzx/MpbOJ7BRkueiPIWcSM3sJC/pnH2roxllDu1Zl5ldm0H1n88WHl0TbQv3x24LdV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=WEn22rq1; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=Z+T0K58g; arc=pass smtp.client-ip=85.215.255.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1708374180; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=i2zrjEwGQoiH4Xfr25qGVanPOn9KQxxbzD01k1ejyo5gCIXevM6nC6gmnLpzFG5VHN
    VpCEdCc9XI0NIDfzCrG5+09MMtN3++XsaKL1R85fkH3WxcdWD6t+GbiAz6Cy8FFRp+tB
    DsJbQ+vOHZKILlvZ3ZYNfnabMZjkmOXkqiAFTDWeQuNSFFGGDRkq1N33K9/hhUyxl1Y4
    2rKB5YrG2hsKf/Kha9VVRD0y1UMaQOcZ8lI5R4qg3nGJYD3AutPG42jombyS8WbdVGfn
    wPhcUsaSOVOK+M6IHGodHheUGB0hSNN38/eAaWzZPxAZHUXd8hL2gZeDlq0NSzzRQwy4
    eahw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1708374180;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=U/L0/LQ6ERPrB/20UgMbzGyW4YIbsTP70z/cZD3wTmU=;
    b=P+yP8K+vbAHxbyrDeEvLF7dxpvEvHg9Bd+6f1cXAn2v1Uzp+lRhjtxXLX2za5h5MFg
    uY7PjHxDYcONGMA6TRKqLnRfX+Urf3sL0aSI7OVeISmTWvymz3ZtrsBpQUCqWvdclQ7U
    Kvplg48T/TZZAz6HJfSUnCT+Oa1pkFRaVwuNN+zhb+6scMMb9y659byOPPFGaI0lQlB9
    G6WCXYAfz78fkz2hwKa531QzU9+U4bmyuxIkMRQ+M7mF0Eayg3LnsjuXwA4tAOsJR0hT
    WlZmSNNoHI9OR9S7ePz2LfW+zulIj+jQ/s6SpiwHXEtGaj6Y65DAABmVtNnJdwt0bwMk
    9g7A==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1708374180;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=U/L0/LQ6ERPrB/20UgMbzGyW4YIbsTP70z/cZD3wTmU=;
    b=WEn22rq1coR8yA5/9x6v1fkpjv6hz9fBcrk45/Dz5J34Cs61X6DicS3NYnAUe0r+Du
    AvZAeN3n81OfzuxZtQMBwaVMjdxblUuzmGhwptMODkImkMWyyiaNrxeWROY2588bNGw5
    h/IM4hbzvNgy10hG5XjQQ1pWV0kj6MwWqMLRbGiWuUChTXMF+Ko5PumLm+AlBm0M7NuU
    T5Z+j5vSGYf7XhSZ120mt4lAbkGEhCwB+17pF+fp0UCd5Q/uZRoxHuc12els8LYsQMOE
    Kn3HOY7pDhjrABM/B2UiVtm3rDHLLHt0XxLEvw77VE1OXboXz80d+46sqFGGN+P74MsO
    gLvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1708374180;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=U/L0/LQ6ERPrB/20UgMbzGyW4YIbsTP70z/cZD3wTmU=;
    b=Z+T0K58gmz4TiX/frKzvbtzsNkF+1WpbYxOVIhpsAXo2t74On1D8jFZZ7/Yyxob7HL
    TEnK8YB871Gn99Cen3CQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusl129OHEdFq0USEbDdAnQ=="
Received: from [IPV6:2a00:6020:4a8e:5000::90c]
    by smtp.strato.de (RZmta 49.11.2 AUTH)
    with ESMTPSA id K49f9c01JKN086H
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 19 Feb 2024 21:23:00 +0100 (CET)
Message-ID: <a41ed65c-a916-424d-b4e7-9db65c015b50@hartkopp.net>
Date: Mon, 19 Feb 2024 21:23:00 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] can: raw: fix getsockopt() for new CAN_RAW_XL_VCID_OPTS
Content-Language: en-US
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, netdev@vger.kernel.org,
 Simon Horman <horms@kernel.org>
References: <20240219200021.12113-1-socketcan@hartkopp.net>
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20240219200021.12113-1-socketcan@hartkopp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Sorry. Of course it is a [PATCH net-next] where the referenced commit 
has been applied.

Best regards,
Oliver

On 2024-02-19 21:00, Oliver Hartkopp wrote:
> The code for the CAN_RAW_XL_VCID_OPTS getsockopt() was incompletely adopted
> from the CAN_RAW_FILTER getsockopt().
> 
> Add the missing put_user() and return statements.
> 
> Flagged by Smatch.
> Fixes: c83c22ec1493 ("can: canxl: add virtual CAN network identifier support")
> Reported-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> ---
>   net/can/raw.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/net/can/raw.c b/net/can/raw.c
> index cb8e6f788af8..897ffc17d850 100644
> --- a/net/can/raw.c
> +++ b/net/can/raw.c
> @@ -833,11 +833,13 @@ static int raw_getsockopt(struct socket *sock, int level, int optname,
>   			if (len > sizeof(ro->raw_vcid_opts))
>   				len = sizeof(ro->raw_vcid_opts);
>   			if (copy_to_user(optval, &ro->raw_vcid_opts, len))
>   				err = -EFAULT;
>   		}
> -		break;
> +		if (!err)
> +			err = put_user(len, optlen);
> +		return err;
>   
>   	case CAN_RAW_JOIN_FILTERS:
>   		if (len > sizeof(int))
>   			len = sizeof(int);
>   		val = &ro->join_filters;

