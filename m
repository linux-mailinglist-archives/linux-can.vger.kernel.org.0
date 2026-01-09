Return-Path: <linux-can+bounces-6091-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2819BD0B7D9
	for <lists+linux-can@lfdr.de>; Fri, 09 Jan 2026 18:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6A9DA3035413
	for <lists+linux-can@lfdr.de>; Fri,  9 Jan 2026 17:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2AAC3644D4;
	Fri,  9 Jan 2026 16:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="Qcw4B8cb";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=valla.it header.i=@valla.it header.b="EwhT3F08"
X-Original-To: linux-can@vger.kernel.org
Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EAF35CB85
	for <linux-can@vger.kernel.org>; Fri,  9 Jan 2026 16:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.56.87.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767977958; cv=pass; b=E9PqK7uyRCIJPEjkAWcadZELtZYM07ZqDaO9NEUYAosUp8Bi06YJX3saHDcAr629O3bkTF0k7T+UDoJnPtUr4mJIPQqCwwMSmCmoG9bqtzU9XIDbwYzyTJQdPAKevTOXwMAcj91oob/XJZwduOoX6DH6X5IJeNWJaTl0GD3NR40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767977958; c=relaxed/simple;
	bh=P9BwpCbBtXcN+Id5YsqJ5AvEB0fHhzdsu7AhWCTSAU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ia+h6NoWXC4vnSezr/OhMQw6TsRvMEyYLzJ2jZvLLvXB5b9PvoECb0wI8ttcCCeaHzF8ICZfiXxGj79fmV8vZS2p2GQYOiz/FjS6pDkbpaCIFek8QjnmeBwifl13FQHYDq6zr5ZqAqO63uOi2udu8VLZd6nZdBPBg9aZU5b/bHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it; spf=pass smtp.mailfrom=valla.it; dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b=Qcw4B8cb; dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b=EwhT3F08; arc=pass smtp.client-ip=185.56.87.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=outgoing.instance-europe-west4-c073.prod.antispam.mailspamprotection.com; s=arckey; t=1767977956;
	 b=LMUiSmBATtrWlTD65B3zRvj/B0hmJ1eIFXDXgCkYbfA+RsQNnp1KyY+TUEUnih7Pv48WeJDYV8
	  wb8fB/kAqwrVAjSdeYjLtbieO/cxQNbowtG/AM2SAFBE1MJoAwfzTr0RW0r8WeK16zPJZvaNqL
	  85oKH9xaBFgGsMxik1LaIwkOrJPV1WNijtWsP+gkMKQPzp3DSWs7R6xzx0TE35aKELRCXJeSs/
	  c8WZhQaO+ywJW6EGjL9nzUcsEx6Mlz9Fu1mj0ggeYuVyumsP7qMFQKsx9KdI4krYLgZY2i5057
	  62+kQ73AntIHa/Lh0pH90sKxarbyN2v2+znuP4TI4rDvow==;
ARC-Authentication-Results: i=1; outgoing.instance-europe-west4-c073.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=outgoing.instance-europe-west4-c073.prod.antispam.mailspamprotection.com; s=arckey; t=1767977956;
	bh=P9BwpCbBtXcN+Id5YsqJ5AvEB0fHhzdsu7AhWCTSAU0=;
	h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	  Message-ID:Subject:Cc:To:From:Date:DKIM-Signature:DKIM-Signature;
	b=Pewbd6UHR7S6mIdweIZANaFcBfTmb9Vsyew9ntrDJJ8kg5VMj5bt5A7nMITpqiww8bosFRxr6s
	  0PcDEpL3tWDXGZeChVgGsBZWFLys3EN0DOFyQM+4UiuZ3xxOeVlHu9+LdIS5XUq+xoNQtxt8MX
	  0Ihzp1AmNGdCbalQcO7SFVoOxpDcKZvOM978y+G3p29JVWy18jE6UwECYC93lHvzfPMqzbNgzy
	  EO+va0Qkcmf7VS9NgTco+IFeHVYuq+NLeQpcTMWEi2fcCxF+IIxyBbIf/MRs50Q5GENm45bg76
	  lLYU+FtFXbkCsELlkQ1vl/eqoFWE7WyQk5UM50O2lE/7pQ==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
	:Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Subject:Cc:To
	:From:Date:Reply-To:List-Unsubscribe;
	bh=iilUOcUAV6K9c1W7Y3wKJUT6c/z6NQwvvlB/VuRuS+A=; b=Qcw4B8cbBhaKoDmAbptgPIAsJf
	GXZNyo9Uo1BjHGt47FAQuK3SDmAIXEcFJ38ph+3NOKW0CMw8+Ze7VJD5kvM11n2sDYhMyT2fOBvc/
	HzsCGGhZ+bn2ktMZgVGbNHYPd3+LpU7lHpPESA5TFLCrrTg6e/32b571Kwq8mgfXefOg=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-c073.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <francesco@valla.it>)
	id 1veFpK-000000043dJ-22zy
	for linux-can@vger.kernel.org;
	Fri, 09 Jan 2026 16:59:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Subject:Cc:To:From:Date:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=iilUOcUAV6K9c1W7Y3wKJUT6c/z6NQwvvlB/VuRuS+A=; b=EwhT3F08izkQkqjBGa+uBapVfX
	9220mY0rvmZNZHSxYoJiyUwkyxme7S3EquaRB23JSzeKvuMmwx1ImHZY7WAqOwoHaZk4+Xm2WrxjV
	83fpiJWdoFE4iO6LOK89gnrn/vme/WkCk9qLCAF3zQxyCWcSWLHONsy9FHBR+vkJCYqs=;
Received: from [95.248.141.113] (port=63988 helo=bywater)
	by esm19.siteground.biz with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <francesco@valla.it>)
	id 1veFp5-00000000DCa-2iWV;
	Fri, 09 Jan 2026 16:58:51 +0000
Date: Fri, 9 Jan 2026 17:58:49 +0100
From: Francesco Valla <francesco@valla.it>
To: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Harald Mommer <harald.mommer@oss.qualcomm.com>,
	Mikhail Golubev-Ciuchea <mikhail.golubev-ciuchea@oss.qualcomm.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-can@vger.kernel.org,
	virtualization@lists.linux.dev,
	Wolfgang Grandegger <wg@grandegger.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH v6] can: virtio: Add virtio CAN driver
Message-ID: <aWEzyc-gt4lEDJIR@bywater>
References: <aQJRnX7OpFRY/1+H@fedora>
 <aQkgsuxa2UaL_qdt@bywater>
 <aTsE1VIk4V/A49HE@fedora>
 <aT7XAsTWr0_yyfx_@bywater>
 <aU6lCL_vrF93lpYa@bywater>
 <CAHYGQ0yHSvhOibhvxtFjZ7H3Tczb22JZ1UuaX5kkOtok0JjDgQ@mail.gmail.com>
 <aV6sHofXnZuu84OV@bywater>
 <aV7lplXiOehmw2iR@bywater>
 <CAHYGQ0yQ=20eFJN-_=_+uqyk=nRyotQLgf01B-Rb8NVk9N4DpQ@mail.gmail.com>
 <CAHYGQ0waHHLOOjX6cSkSHkNRGYDqsCccKUa5E2DGZwR9DtjMUA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHYGQ0waHHLOOjX6cSkSHkNRGYDqsCccKUa5E2DGZwR9DtjMUA@mail.gmail.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: 067fd7436413e78520e720560445b904
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1veFpK-000000043dJ-22zy-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-c073.prod.antispam.mailspamprotection.com;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none

Hi Matias,

On Thu, Jan 08, 2026 at 09:21:38PM +0100, Matias Ezequiel Vara Larsen wrote:
> On Thu, Jan 8, 2026 at 12:21 AM Matias Ezequiel Vara Larsen
> <mvaralar@redhat.com> wrote:
> >
> > Thanks Francesco! right, I made a mistake. process_rx_queue() is only
> > invoking signal_used_queue() when req_rx_buf is true, i.e., the device
> > has actually added something to the used ring. I'll fix that.
> >
> Feel free to test the updated commit. I just fixed a few bugs. So far
> my tests seem correct.

I stressed this during the night without any issue. So I'd say it is now
working.

> 
> Matias
> 
> 

Thank you!

Francesco


