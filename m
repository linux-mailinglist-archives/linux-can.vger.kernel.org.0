Return-Path: <linux-can+bounces-2097-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B12669D1CC3
	for <lists+linux-can@lfdr.de>; Tue, 19 Nov 2024 01:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7510A2824D6
	for <lists+linux-can@lfdr.de>; Tue, 19 Nov 2024 00:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDAE512B93;
	Tue, 19 Nov 2024 00:49:05 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail.enpas.org (zhong.enpas.org [46.38.239.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282FF1F941;
	Tue, 19 Nov 2024 00:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.38.239.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731977345; cv=none; b=ni/rPqlY2sEw7PodNlQRM+oDf44FU0FCYs+zIG1Ij3NdGi7nfDbDQHDywsbh6kmMRvQORSXdliGQp2mK4ikBHiuIPl6VAynjEWDo7QMY0q5sZssKmH0ryzjOx8ELT8ixsehlwtsaU6EDThES1zjvxyGkubVps/PR14Hl40zMl7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731977345; c=relaxed/simple;
	bh=J+WPrwsuAWpNkX7H54JmUhwKRSLKv+/L5TWT0yg4wEI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YxU654aRtnEWnOfcs0iSILvBFPSVPJ6qtc+6Mbfqb3SZfeSkuEUaB75j3pYROyW60Vnga5Q5Q0REwkllJgw0kQ29l+ekQH/aCnb93drBsV+76yuu+HlA0Wl3Ua8dJhjaJcmag8u1wW+L/YiKCr+KHFCQySq3nMJ74dfuV7p5nXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enpas.org; spf=pass smtp.mailfrom=enpas.org; arc=none smtp.client-ip=46.38.239.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enpas.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enpas.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by mail.enpas.org (Postfix) with ESMTPSA id 890EB102ECB;
	Tue, 19 Nov 2024 00:48:56 +0000 (UTC)
Message-ID: <8c358157-d28d-4c42-b983-4191061edd70@enpas.org>
Date: Tue, 19 Nov 2024 09:48:53 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] can: can327: fix snprintf() limit in
 can327_handle_prompt()
Content-Language: en-US
To: Dan Carpenter <dan.carpenter@linaro.org>,
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-can@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <c896ba5d-7147-4978-9e25-86cfd88ff9dc@stanley.mountain>
 <6db4d783-6db2-4b86-887c-3c95d6763774@wanadoo.fr>
 <4ff913b9-93b3-4636-b0f6-6e874f813d2f@stanley.mountain>
 <9d6837c1-6fd1-4cc6-8315-c1ede8f20add@wanadoo.fr>
 <20241114-olive-petrel-of-culture-5ae519-mkl@pengutronix.de>
 <7841268c-c8dc-4db9-b2dd-c2c5fc366022@wanadoo.fr>
 <0c4ebaf0-a6c5-4852-939b-e7ac135f6f32@stanley.mountain>
 <7d4b176b-6b44-450b-ab2d-847e5199d1b9@wanadoo.fr>
 <e5572514-83d7-4b7e-b4f0-5318c6722250@stanley.mountain>
From: Max Staudt <max@enpas.org>
In-Reply-To: <e5572514-83d7-4b7e-b4f0-5318c6722250@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

As promised, here is a patch cleaning up can327's payload "encoding" 
(the hex dump part), plus a comment explaining why Dan's finding turned 
out not to be security relevant. It's as Vincent already explained, plus 
additional background information:

  
https://lore.kernel.org/linux-can/20241119003815.767004-1-max@enpas.org/T/

I've taken the liberty of not CC'ing the network maintainers on that 
patch, hence this email with a pointer to it for anyone interested. In 
the end, while it looked worrying at first, it ended up being just a 
minor cleanup.


Thanks Dan for pointing out that ugly piece of code. I'd really like to 
one day find the time to do some further cleanup, and especially further 
commenting in order to reduce the bus factor, but oh well...


Max


