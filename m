Return-Path: <linux-can+bounces-603-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB48B8C0498
	for <lists+linux-can@lfdr.de>; Wed,  8 May 2024 20:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 185061C20EA2
	for <lists+linux-can@lfdr.de>; Wed,  8 May 2024 18:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37DD84A34;
	Wed,  8 May 2024 18:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="u3xwpj8W"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BEE1E521;
	Wed,  8 May 2024 18:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715194101; cv=none; b=YRFjv/MGdIpjxLwlfF3/6OZcBJ5rOoQg60yeurQhDQJmXbWXxHU3JJQaZV3eiakEUMAn9cuKwXMPLFzbr19MJmdy6QXppSmaUEN2H0ivIhkyYTQ6TZzfCeMGs6wSo/KdJCoJiDk05zNENq0nb+3asao7068JjUHXHfNB5HuJpPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715194101; c=relaxed/simple;
	bh=JSN51QMeVWBL5ZlNRHJJjZtaLYDfa+v+XlsqBseMV0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k5Z6GaroAIQ4q+BTt0Je37DsTljvXX7Xzv2QFC4I08PJuoBRHiLP/VdV0SiSWV9vuqkGjzFG+IdKkm5n8t3+ipJGnOOM+vfY1uyIBF3RD9KaEBWnbRrWrDscdH8J46mJSZ4cp9CfocS2A4uEeCSVLvklZamnaMu8AK1lm0pIVgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=u3xwpj8W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9144BC113CC;
	Wed,  8 May 2024 18:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715194101;
	bh=JSN51QMeVWBL5ZlNRHJJjZtaLYDfa+v+XlsqBseMV0M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u3xwpj8WHxR3j6K/wO1YBf5Uei8unwUijfe08+sBEUavcKFc+bBq7sz8L15Vij6gX
	 e6N0Bizv0tdTlsMbKBpzpZ2hvE9AzlAw1jJ10GEw5Vicq+qzfAwuqeimPvey2ZTBN4
	 tzrZUNvjR4rs8vnZuyQoHz4keOTmHKnahmluP9nM=
Date: Wed, 8 May 2024 19:48:18 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Christoph Fritz <christoph.fritz@hexdev.de>
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Jiri Slaby <jirislaby@kernel.org>,
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
	Netdev <netdev@vger.kernel.org>, devicetree@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-serial <linux-serial@vger.kernel.org>
Subject: Re: [PATCH v3 01/11] can: Add LIN bus as CAN abstraction
Message-ID: <2024050852-vixen-arson-cb42@gregkh>
References: <20240502182804.145926-1-christoph.fritz@hexdev.de>
 <20240502182804.145926-2-christoph.fritz@hexdev.de>
 <61adf428-2205-1563-d0b6-fa843e08559d@linux.intel.com>
 <e0f3d0716ed2f4281561f08bbcd3050dddcf1831.camel@hexdev.de>
 <4e8a50a0-f938-8aaf-fe4b-d18765407d4d@linux.intel.com>
 <215d898a0244d717467d44a8e93f186e2f282daa.camel@hexdev.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <215d898a0244d717467d44a8e93f186e2f282daa.camel@hexdev.de>

On Wed, May 08, 2024 at 08:20:51PM +0200, Christoph Fritz wrote:
> ...
> > ...
> > > > > +static int lin_create_sysfs_id_files(struct net_device *ndev)
> > > > > +{
> > > > > +	struct lin_device *ldev = netdev_priv(ndev);
> > > > > +	struct kobj_attribute *attr;
> > > > > +	int ret;
> > > > > +
> > > > > +	for (int id = 0; id < LIN_NUM_IDS; id++) {
> > > > > +		ldev->sysfs_entries[id].ldev = ldev;
> > > > > +		attr = &ldev->sysfs_entries[id].attr;
> > > > > +		attr->attr.name = kasprintf(GFP_KERNEL, "%02x", id);
> > > > > +		if (!attr->attr.name)
> > > > > +			return -ENOMEM;
> > > > > +		attr->attr.mode = 0644;
> > > > > +		attr->show = lin_identifier_show;
> > > > > +		attr->store = lin_identifier_store;
> > > > > +
> > > > > +		sysfs_attr_init(&attr->attr);
> > > > > +		ret = sysfs_create_file(ldev->lin_ids_kobj, &attr->attr);
> > > > > +		if (ret) {
> > > > > +			kfree(attr->attr.name);
> > > > > +			return -ENOMEM;
> > > > > +		}
> > > > > +	}
> > > > > +
> > > > > +	return 0;
> > > > > +}
> > > > 
> > > > Can you use .dev_groups instead ?
> > > 
> > > I'm not sure where to attach this in this glue code here. Should I do a
> > > class_register() and add the .dev_groups there?
> > 
> > I guess struct class would be correct direction but I'm not sure if it's 
> > viable in this case. It would avoid the need for custom sysfs setup code
> > if it's workable.
> 
> I just tried to find a way, but these are 64 sysfs files and declaring
> them all static looks a bit odd to me. I might be missing something
> here.
> 
> For v4 I would stick to the dynamic setup and fix the rollback.
> 
> Any objections?

Yes, you race with userspace and loose by trying to do this "by hand".
Make this static please.

thanks,

greg k-h

