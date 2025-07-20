Return-Path: <linux-can+bounces-4011-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 761FDB0B7DC
	for <lists+linux-can@lfdr.de>; Sun, 20 Jul 2025 21:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 031A47A87E5
	for <lists+linux-can@lfdr.de>; Sun, 20 Jul 2025 19:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635B0191F84;
	Sun, 20 Jul 2025 19:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="s2k/9quH"
X-Original-To: linux-can@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F87208A7;
	Sun, 20 Jul 2025 19:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753038212; cv=none; b=KNBhF9M6uFa/PKIKgGa0WHo75wBZsOBRrBcV+4JXfr0JuzCHXzWyZcVqZWCaQcdi5EOkkHAslTwB4R1bL8m2KYIGfwKQc0O8pPCT8XRnMRwqchvEcveCv236g7yjT9stAbVjTYgTPaIReRZr4Z4CuevN9AUyGsJo7uPbSqoysbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753038212; c=relaxed/simple;
	bh=iE6TtE5Ov0di9V8wbzKMMqbyjyUWNwN+I6m+o5M6yLE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=XmUWxuhvVrh01ol4PAjLiShvuYcqqWqQjjxpNKiZC9AeJCGTPewoMsRPUK/zkYtk02PT/uaW5f5VJ/wHi8U6HGwsJCHcnzlrQL/vfd3XNJS9O3TLimdklytwGViViN3tsMe/ubCZnUaBS2++7LTWZNmdPePT84M/1XSKBkTJFpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=s2k/9quH; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:Subject:From:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=xkzdKJ3lk4I4vs26NXktpSOwrbAH72NKvcb1q5Ihx3s=; b=s2k/9quHKBVGrcpd5NfGq9lO9/
	PS21NQTpMIdc4qUREbvuGtpZm7958eAJuWRIFqEpfK5y7uZnddiDybWbOoydTe69v39l7xk7fIe9Y
	ny4Ea3zDvKXu7AUFFdAtknI7MbiyMZ5hGbyugnVpOkeqn3BIxcn4BAfjScpKNm872wNqBira778WD
	MYnIx70SJemr7jOvy2/p4r9d/2VTAYlz5vuGbcrgzlicSMqsots1ncDIcSQf+dj3bwTEXLTP6NeA4
	TCZ10lXc8Mf7/XohVt3vF7wxmbHhBDKY2eDGNgyOKUURMFgllv+pw6syp6A2SLKKQArXFIoGnQ6PL
	g7po11Cg==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1udZJh-0000000Fe6h-42Cp;
	Sun, 20 Jul 2025 19:03:22 +0000
Message-ID: <1b00e570-f51e-4768-a882-d03252d84534@infradead.org>
Date: Sun, 20 Jul 2025 12:03:19 -0700
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2 1/1] docs: Fix kernel-doc indentation errors
To: Luis Felipe Hernandez <luis.hernandez093@gmail.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Pavel Pisa <pisa@cmp.felk.cvut.cz>, Ondrej Ille <ondrej.ille@gmail.com>,
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Frank Li <Frank.Li@nxp.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-i3c@lists.infradead.org,
 linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250720152401.70720-1-luis.hernandez093@gmail.com>
 <20250720152401.70720-2-luis.hernandez093@gmail.com>
Content-Language: en-US
In-Reply-To: <20250720152401.70720-2-luis.hernandez093@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

+ Bagas

On 7/20/25 8:24 AM, Luis Felipe Hernandez wrote:
> Fix kernel-doc issues that reported Unexpected indentation errors
> durring documentation build (make htmldocs) in CAN, I3C and GPU drivers.
> 
> Convert formatting to proper ReST list syntax to resolve warning.
> 
> Changes since v1:
> - Convert return value descriptions to proper ReST format
> - Fix code block introduction with :: syntax  
> - Add GPU driver fixes
> - Remove SCSI driver (already fixed)
> 
> Link: https://lore.kernel.org/all/20250703023511.82768-1-luis.hernandez093@gmail.com/
> 
> Signed-off-by: Luis Felipe Hernandez <luis.hernandez093@gmail.com>
> ---
>  drivers/gpu/drm/drm_gpuvm.c              | 16 ++++++++--------

drm_gpuvm.c fixed by Bagas:

  https://lore.kernel.org/linux-doc/20250709024501.9105-1-bagasdotme@gmail.com/

Otherwise LGTM.

>  drivers/i3c/device.c                     | 13 ++++++++-----

i3c is also fixed by Bagas:
  https://lore.kernel.org/linux-i3c/20250702040424.18577-1-bagasdotme@gmail.com/

Otherwise LGTM.

>  drivers/net/can/ctucanfd/ctucanfd_base.c | 12 +++++++-----
>  3 files changed, 23 insertions(+), 18 deletions(-)
> 

> diff --git a/drivers/net/can/ctucanfd/ctucanfd_base.c b/drivers/net/can/ctucanfd/ctucanfd_base.c
> index bf6398772960..f910422188c3 100644
> --- a/drivers/net/can/ctucanfd/ctucanfd_base.c
> +++ b/drivers/net/can/ctucanfd/ctucanfd_base.c
> @@ -506,11 +506,13 @@ static bool ctucan_is_txt_buf_writable(struct ctucan_priv *priv, u8 buf)
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
> + *
> + *   * TXT Buffer is not writable (it is in wrong state)
> + *   * Invalid TXT buffer index
> + *   * Invalid frame length
>   */
>  static bool ctucan_insert_frame(struct ctucan_priv *priv, const struct canfd_frame *cf, u8 buf,
>  				bool isfdf)

The numbered list is not a problem AFAIK. Did you see an issue with it?
And having the blank line just before the "False" list causing undesirable
html output:

Return

 * True - Frame inserted successfully

 * False - Frame was not inserted due to one of:

Description

 * TXT Buffer is not writable (it is in wrong state)

 * Invalid TXT buffer index

 * Invalid frame length

The "Description" line should not be there.

IMO all we want to do is convert the True and False lines into
a bulleted list and then the html output will look like this:

Return

 * True - Frame inserted successfully

 * False - Frame was not inserted due to one of:
	1. TXT Buffer is not writable (it is in wrong state)
	2. Invalid TXT buffer index
	3. Invalid frame length


-- 
~Randy

