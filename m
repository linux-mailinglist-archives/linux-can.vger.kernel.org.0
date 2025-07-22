Return-Path: <linux-can+bounces-4032-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72672B0E409
	for <lists+linux-can@lfdr.de>; Tue, 22 Jul 2025 21:22:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56CE11AA8133
	for <lists+linux-can@lfdr.de>; Tue, 22 Jul 2025 19:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B853283FE7;
	Tue, 22 Jul 2025 19:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BwS7nU23"
X-Original-To: linux-can@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE15283689;
	Tue, 22 Jul 2025 19:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753212165; cv=none; b=hAe/f7Ut2xNVBr/pD+L91P/g8mS3R11PDLg71dTygO3iWbOG+eqJznLz+e8VMQ2lNJXW2+92cLB7RZ+X7UT6X3B3kW9bjLZcobAYbwq0gOASUQAsk6Cu/UwqDCp1F9r1bymhhTMgZN5qoUmAMrrpM37534U9njPE1pZ3DRRB4Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753212165; c=relaxed/simple;
	bh=o3/Nt8VWAqZdQnM3v22/fuvAN8LV6F+s9UVbugzkiUY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dp1/d7MslK+s5936FZW1QtteJZuXNhuyEGBcAwIdxRNtzWB+6SOjNITewYywNMAZc2bAU3swJgA3tSju8ghl0x9pVQH+Ixm4ZqLJxdmXgffszCaZV+SA0PpzIEG6wkoQwwImNGwXXKtcBgdK6A0YJENNB7NvCQcrPc5NfL6CHUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BwS7nU23; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=tTGFlNCEgg13gFx2shdWP5jEfbbhmLWVMbA1lyv25mc=; b=BwS7nU23TNOvoK9jBYT0o6Y3u7
	c4E5BYt3zhAePcuAV4T1BlR9Curfu80jrptTpceVaYgLgk12N8mCf0rs0Q8oDZW6vLrq/Eg/BMxnD
	IyYyUcBYEA6b7m8aWlFug2NFAc2qFv2br6ZOoRmwwHKBseAa8hTsqQLW9TN7By6Wzq2B1lHpBz74b
	8fg8kEN2bewxEynSkEaDw7nXLCuR2ZI4Nmxk+IMn5h5FpuGcktaMh/233TvEJX/MHG31nxs2TAkOI
	joLvZ9pvC6nzSafAsn6tW6GvFGs/+aCEhjYVioUM3ZeUm2y9ihpU2lV+Li9tmkKLMjz/WfkqCs8if
	6ovpj+AQ==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ueIZQ-00000003L3r-3kf4;
	Tue, 22 Jul 2025 19:22:36 +0000
Message-ID: <1faa5e2e-6b1b-4fea-9132-8a840357927f@infradead.org>
Date: Tue, 22 Jul 2025 12:22:36 -0700
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] docs: Fix kernel-doc error in CAN driver
To: Luis Felipe Hernandez <luis.hernandez093@gmail.com>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Ondrej Ille <ondrej.ille@gmail.com>,
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250722035352.21807-1-luis.hernandez093@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250722035352.21807-1-luis.hernandez093@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/21/25 8:53 PM, Luis Felipe Hernandez wrote:
> Fix kernel-doc formatting issue causing unexpected indentation error
> in ctucanfd driver documentation build. Convert main return values
> to bullet list format while preserving numbered sub-list in order to
> correct indentation error and visual structure in rendered html.
> 
> Signed-off-by: Luis Felipe Hernandez <luis.hernandez093@gmail.com>
> 
> ---
> Changes since v2:
> - Focus only on CAN driver (GPU and I3C already fixed by Bagas Sanjaya)
> - Remove blank line that caused unwanted 'Description' output
> - Keep numbered sub-list format as suggested by Randy Dunlap
> - Move changelog after cutter as suggested by Vincent Mailhol
> 
> Link(v2): https://lore.kernel.org/all/20250720152401.70720-1-luis.hernandez093@gmail.com/
> Link(v1): https://lore.kernel.org/all/20250703023511.82768-1-luis.hernandez093@gmail.com/
> ---
>  drivers/net/can/ctucanfd/ctucanfd_base.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/can/ctucanfd/ctucanfd_base.c b/drivers/net/can/ctucanfd/ctucanfd_base.c
> index bf6398772960..8bd3f0fc385c 100644
> --- a/drivers/net/can/ctucanfd/ctucanfd_base.c
> +++ b/drivers/net/can/ctucanfd/ctucanfd_base.c
> @@ -506,11 +506,12 @@ static bool ctucan_is_txt_buf_writable(struct ctucan_priv *priv, u8 buf)
>   * @buf:	TXT Buffer index to which frame is inserted (0-based)
>   * @isfdf:	True - CAN FD Frame, False - CAN 2.0 Frame
>   *
> - * Return: True - Frame inserted successfully
> - *	   False - Frame was not inserted due to one of:
> - *			1. TXT Buffer is not writable (it is in wrong state)
> - *			2. Invalid TXT buffer index
> - *			3. Invalid frame length
> + * Return:
> + * * True - Frame inserted successfully
> + * * False - Frame was not inserted due to one of:
> + *	1. TXT Buffer is not writable (it is in wrong state)
> + *	2. Invalid TXT buffer index
> + *	3. Invalid frame length
>   */
>  static bool ctucan_insert_frame(struct ctucan_priv *priv, const struct canfd_frame *cf, u8 buf,
>  				bool isfdf)

Looks good. Thanks for doing this.

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

-- 
~Randy

