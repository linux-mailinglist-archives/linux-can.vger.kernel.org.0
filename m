Return-Path: <linux-can+bounces-4698-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA11B57610
	for <lists+linux-can@lfdr.de>; Mon, 15 Sep 2025 12:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 963237AF07B
	for <lists+linux-can@lfdr.de>; Mon, 15 Sep 2025 10:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0902FB089;
	Mon, 15 Sep 2025 10:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="A2FbFR0v"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139672FB63A;
	Mon, 15 Sep 2025 10:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757931500; cv=pass; b=colnFcqbm6+omY8refKqjJfApYvuntIs1vy1vRhWfKHzpXUJkKzEjHevufG4w+HmshHKGERhvrNlQEOe36jSfZHoFnJBg9GM3aJ7e/0Fhcfxbro1jdh9De5MoMxDlwlcu7kQ2qXeknmWaQw0zhkJU8l7YbwNd2O/NOdLbu2xcPc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757931500; c=relaxed/simple;
	bh=yq7M6JP3Oq+d/cbP5IGvtLG+k2CbFjlMFdkIARemTlY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HqS4WEGIEj88uAM5ZTUIdAA5BWSmTKtKixpamSRIo6kMqAvCZVo/n8O8W41yQOZsHKdd515Cltn5ThMjckwr9JXovjQ9zELFUVscHTCqOjA7NabaABfw4EtUsFovuHh71A8uCN5md/Sv8bqwjD/Z9rhTpGMg1Ybi5kzCp1hEteE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=A2FbFR0v; arc=pass smtp.client-ip=85.215.255.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1757931489; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=mttNDOFfLygc3gNw+UETJm0YwNQLjt+EOZViHG5dv42/4lv1eQu8ExYuUUPhqDMZfE
    HQAnfYQTXrOscecwnvHoUEfex1aWoA8c4TaJb8Ijcwd9Qb5hSQq/E+dPM2kgsO8SQaHC
    v4LLJJeHxyXGvU3c0KAsrQu/YOJolBMYI7m+uf3krPx4/9fXlati4/Q73Ak43xLr2g41
    g/JWmhf0fKs09uep77Onziy1Sj3C7cTThHutWqDIfzrWSQL69DIYuT9P0mu+Dsyk07XU
    qlxnJ9ee5CuomJTLA3+tTuv0Geg3ycAlBDNh+DuTaIdFamPzUleD/mZfDnQaJjg1ySjq
    cG4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1757931489;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=tIy57BRWTHlMjXj/FqYvAxp04YX3tnZ0XeC2iuc8VC0=;
    b=t1L3aeQlYepQRgchZjAvOvOCDbY3blXlNKuh/yAefISxpSjDPg64kEuH75MhQ/omKT
    WNu7sE8bOVYTrSkgRsSYb7zc98cRsRRNoteJ4pXDj3pc7PaNrpBKlc4pH2cYFL3kgv/U
    P3sIJdXEZf3DlcdHjD2Hy+tqnegn/RhTYCwbNrerYU315SdSA3Cz8MrMl7EaBiBH0ozm
    ctFzwcx0q0gMXWxvgpFW5nG3u2APfN0+YCjntmpAXr12oiyGe7Srilksex2DuG9gV8m4
    e//SXcDcVfH4htTnWU1XuCUQdCY2Kk/gbhqHMZwCLKAYeLKlck+9q4plPKt2NClX3FMe
    XpWQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1757931489;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=tIy57BRWTHlMjXj/FqYvAxp04YX3tnZ0XeC2iuc8VC0=;
    b=A2FbFR0vstMHSzHFLI/RmtlCzyIo9bWdFcbZNzqFB/DqfHwWdWoZpuysbTPvKv/gQS
    L4M/DwsJgd2igIMmZVgB99GdyKYf0lJU0Vg92z/X4ciDkMgX2Q8C0GFQVqNN7uVZZgBD
    yGxq2GtsSbNi45xlEXLLRZskdOYnJmSNNqbTt/CpNde4Za1/ASCXqPtJaOx0/vDEiAZL
    LY2DZkbTQFh8Q11uCoI9HrO/xfUolmjck0a6gS/lltN9ztTXjsc0Fv4J3iuQO2JyV3d3
    n4a3qxVzZ1ZVqPghK8Sr+DauzyRYGcbDzb4j7hvfrmG+YHPHLI5XFJ4vHxCJQ4tc5sco
    fBNQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMr5owMnk64sm8VF6OpcIrgdno+M3mNGEGSIofQp0UJwtSeLY="
Received: from [IPV6:2a02:b98:8b0e:d800:856:bd03:6d59:abd2]
    by smtp.strato.de (RZmta 52.1.2 AUTH)
    with ESMTPSA id K2a23218FAI90n8
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 15 Sep 2025 12:18:09 +0200 (CEST)
Message-ID: <9b0309f9-803c-41e0-b456-bd9ac20e2277@hartkopp.net>
Date: Mon, 15 Sep 2025 12:18:09 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] can: raw: reorder struct uniqframe's members to
 optimise packing
To: Vincent Mailhol <mailhol@kernel.org>,
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250915-can-raw-repack-v1-0-5ea293bc6d33@kernel.org>
 <20250915-can-raw-repack-v1-1-5ea293bc6d33@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20250915-can-raw-repack-v1-1-5ea293bc6d33@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 15.09.25 11:23, Vincent Mailhol wrote:
> struct uniqframe has one hole. Reorder the fields to save 8 bytes.
> 
> Statistics before:
> 
>    $ pahole --class_name=uniqframe net/can/raw.o
>    struct uniqframe {
>    	int                        skbcnt;               /*     0     4 */
> 
>    	/* XXX 4 bytes hole, try to pack */
> 
>    	const struct sk_buff  *    skb;                  /*     8     8 */
>    	unsigned int               join_rx_count;        /*    16     4 */
> 
>    	/* size: 24, cachelines: 1, members: 3 */
>    	/* sum members: 16, holes: 1, sum holes: 4 */
>    	/* padding: 4 */
>    	/* last cacheline: 24 bytes */
>    };
> 
> ...and after:
> 
>    $ pahole --class_name=uniqframe net/can/raw.o
>    struct uniqframe {
>    	const struct sk_buff  *    skb;                  /*     0     8 */
>    	int                        skbcnt;               /*     8     4 */
>    	unsigned int               join_rx_count;        /*    12     4 */
> 
>    	/* size: 16, cachelines: 1, members: 3 */
>    	/* last cacheline: 16 bytes */
>    };
> 
> Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>

> ---
>   net/can/raw.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/can/raw.c b/net/can/raw.c
> index 76b867d21def209f5c6d236604c0e434a1c55a4d..db21d8a8c54d1b6a25a72c7a9d11d5c94f3187b5 100644
> --- a/net/can/raw.c
> +++ b/net/can/raw.c
> @@ -75,8 +75,8 @@ MODULE_ALIAS("can-proto-1");
>    */
>   
>   struct uniqframe {
> -	int skbcnt;
>   	const struct sk_buff *skb;
> +	int skbcnt;
>   	unsigned int join_rx_count;
>   };
>   
> 


