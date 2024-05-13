Return-Path: <linux-can+bounces-635-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C748C3E66
	for <lists+linux-can@lfdr.de>; Mon, 13 May 2024 11:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F06E21C212E4
	for <lists+linux-can@lfdr.de>; Mon, 13 May 2024 09:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F062148848;
	Mon, 13 May 2024 09:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oDH8BtR7"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFFA147C91;
	Mon, 13 May 2024 09:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715594021; cv=none; b=gTXABifL8+mEdgZM1EeGSo92A7no2/mt5IsuCUk7istVFh3J745YEnP2gOmUqNH+o0LwMjZzbbR8oqI1TORg9JeP0IbYA2OUrx873MedZDQXDsoOSolUG7DbsrtqJ7wcA+9b/C7wAFIVC5Mi3nqnLrMJr3XsrHwN0mNUKJ8nBds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715594021; c=relaxed/simple;
	bh=pSaP0oKyXtPiLCTwVDsndP7Da0tNxbGDydC7EAOZaOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KqzfSCuhqO96ADpsZCr4mobXXZlxtDfbKwDCCc9NAlKWsuoOnAa8TB1dUUWdu6Y9tmgWDpYf3c60dTA1MrpMw2KwetrjEEzp1lgkaTZqosGP9yZ7JHKJ0k2LPIlP8qghP4esWlri+AusACHfFti7N6r67BfrW5tPnyUToTi/FIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oDH8BtR7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A134FC113CC;
	Mon, 13 May 2024 09:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715594020;
	bh=pSaP0oKyXtPiLCTwVDsndP7Da0tNxbGDydC7EAOZaOc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oDH8BtR7U1DF64D91khI6qNkuu0IIMeFSn6k0bWuBvr6N7gvCZE+agcNrkqSUmjul
	 xqcun+22g6m4282s6JvtoQDvBKxrtOgNFNQgEQlXePsE9Z9yrWBmAyYdt4o+n6F5NM
	 btbDXu6kHmA08Ep1pgAKCLcTS+1i5iJZE0VfvoY0YA2XrQ7zVdVCP/bniB/1hR7BwZ
	 XsJzN7zfTVjyqBdSOeva+VKdYH39d3sq2EKXkIuOpZg0qjDo2p8A1TU9D6JbhUpbWZ
	 8O4bI70twUxCU6nRnI5ZXnghsNWD8+3muRVF1Zr4TQH005zkZVi7ll9WwQhA9PXKnv
	 Ny/3PndzxRSWQ==
Date: Mon, 13 May 2024 10:52:03 +0100
From: Simon Horman <horms@kernel.org>
To: Christoph Fritz <christoph.fritz@hexdev.de>
Cc: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Andreas Lauser <andreas.lauser@mercedes-benz.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Pavel Pisa <pisa@cmp.felk.cvut.cz>, linux-can@vger.kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-input@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v4 01/11] can: Add LIN bus as CAN abstraction
Message-ID: <20240513095203.GJ2787@kernel.org>
References: <20240509171736.2048414-1-christoph.fritz@hexdev.de>
 <20240509171736.2048414-2-christoph.fritz@hexdev.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240509171736.2048414-2-christoph.fritz@hexdev.de>

On Thu, May 09, 2024 at 07:17:26PM +0200, Christoph Fritz wrote:
> Introduce a LIN (local interconnect network) abstraction on top of CAN.
> This is a glue driver adapting CAN on one side while offering LIN
> abstraction on the other side. So that upcoming LIN device drivers can
> make use of it.
> 
> Tested-by: Andreas Lauser <andreas.lauser@mercedes-benz.com>
> Signed-off-by: Christoph Fritz <christoph.fritz@hexdev.de>

...

> +#define LID(_name) \
> +	struct device_attribute linid_##_name = __ATTR(_name, 0644, \
> +	lin_identifier_show, lin_identifier_store)
> +
> +LID(00); LID(01); LID(02); LID(03); LID(04); LID(05); LID(06); LID(07);
> +LID(08); LID(09); LID(0a); LID(0b); LID(0c); LID(0d); LID(0e); LID(0f);
> +LID(10); LID(11); LID(12); LID(13); LID(14); LID(15); LID(16); LID(17);
> +LID(18); LID(19); LID(1a); LID(1b); LID(1c); LID(1d); LID(1e); LID(1f);
> +LID(20); LID(21); LID(22); LID(23); LID(24); LID(25); LID(26); LID(27);
> +LID(28); LID(29); LID(2a); LID(2b); LID(2c); LID(2d); LID(2e); LID(2f);
> +LID(30); LID(31); LID(32); LID(33); LID(34); LID(35); LID(36); LID(37);
> +LID(38); LID(39); LID(3a); LID(3b); LID(3c); LID(3d); LID(3e); LID(3f);

Hi Christoph,

Sparse flags that the structures defined by the above code are not
declared elsewhere, and therefore likely should be static.
> +
> +static struct attribute *lin_sysfs_attrs[] = {
> +	&linid_00.attr, &linid_01.attr, &linid_02.attr, &linid_03.attr,
> +	&linid_04.attr, &linid_05.attr, &linid_06.attr, &linid_07.attr,
> +	&linid_08.attr, &linid_09.attr, &linid_0a.attr, &linid_0b.attr,
> +	&linid_0c.attr, &linid_0d.attr, &linid_0e.attr, &linid_0f.attr,
> +	&linid_10.attr, &linid_11.attr, &linid_12.attr, &linid_13.attr,
> +	&linid_14.attr, &linid_15.attr, &linid_16.attr, &linid_17.attr,
> +	&linid_18.attr, &linid_19.attr, &linid_1a.attr, &linid_1b.attr,
> +	&linid_1c.attr, &linid_1d.attr, &linid_1e.attr, &linid_1f.attr,
> +	&linid_20.attr, &linid_21.attr, &linid_22.attr, &linid_23.attr,
> +	&linid_24.attr, &linid_25.attr, &linid_26.attr, &linid_27.attr,
> +	&linid_28.attr, &linid_29.attr, &linid_2a.attr, &linid_2b.attr,
> +	&linid_2c.attr, &linid_2d.attr, &linid_2e.attr, &linid_2f.attr,
> +	&linid_30.attr, &linid_31.attr, &linid_32.attr, &linid_33.attr,
> +	&linid_34.attr, &linid_35.attr, &linid_36.attr, &linid_37.attr,
> +	&linid_38.attr, &linid_39.attr, &linid_3a.attr, &linid_3b.attr,
> +	&linid_3c.attr, &linid_3d.attr, &linid_3e.attr, &linid_3f.attr,
> +	NULL
> +};

...

