Return-Path: <linux-can+bounces-5097-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C60BB10D0
	for <lists+linux-can@lfdr.de>; Wed, 01 Oct 2025 17:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77E55189036E
	for <lists+linux-can@lfdr.de>; Wed,  1 Oct 2025 15:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280E1274FDF;
	Wed,  1 Oct 2025 15:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RLQz5Z2Z"
X-Original-To: linux-can@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF9418DB01
	for <linux-can@vger.kernel.org>; Wed,  1 Oct 2025 15:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759332217; cv=none; b=Wirg6r7jlDWgmNCKgUhHE/RO0OE94me4Ib4g9KIcBkWezaJejNuaExcX3LetLJ6lnKY343EbaNn/YhZljb8CFepP+yTzGIb4zWHmc+8MfQ7dPhiE2C7JOBJOFG1Iwj75ajO0YZ7NznN0vWrs8FrQUv80R5ADMRx3VjVvhrNZUWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759332217; c=relaxed/simple;
	bh=iBktchbTFIkQVIZCHXu3rzcyooPQa8aMp3zZsKHXgNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KPgr1yIvDhrEFDGVr5W0PadJTGeEFeaCMQkZqlUEyqhQLTAVgGLPuhaJrHy+VLmSH1PIP/lRXUJjw/jjNT+kL79nJm1LDDJBVAyvS5tvzkxwhtN/DN80tQvoQaeNSkvSJgglYN8bmB7j+vrnnjpDXW6jcXUXwkj6VAJpDb3j9eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RLQz5Z2Z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759332214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L8KTVkxDaTugQkJkjdBtyRDidD31YHiR8yeBnSmByJ8=;
	b=RLQz5Z2ZmlYt+wLzkAwPydlWigwm6m/9ftAS3s143C3kIG3bYAuRWyTqz4Jso7FzE4iFUr
	AvkTnE7tzOptfTT4NxZVHT/wwmlSOyL+nyv2FwhtFWkCX8uQ5e72vIJ9Hrnubb7UaU0jrX
	kT+8LgvJHqaSNV8Wt6hRGbwkVwSJdOg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-c2Jk8poQOuy8PUtwhjNu4A-1; Wed, 01 Oct 2025 11:23:33 -0400
X-MC-Unique: c2Jk8poQOuy8PUtwhjNu4A-1
X-Mimecast-MFC-AGG-ID: c2Jk8poQOuy8PUtwhjNu4A_1759332212
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3f7b5c27d41so788896f8f.0
        for <linux-can@vger.kernel.org>; Wed, 01 Oct 2025 08:23:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759332212; x=1759937012;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L8KTVkxDaTugQkJkjdBtyRDidD31YHiR8yeBnSmByJ8=;
        b=IaZQ7t6+Pc0+Y4z5pXJFmd8tSAlkOSnyjqxUTQqiMMYeR8LJ2gkreV/iIKJ8d8Wp/C
         wHUHt8c1DyZuIfrG1xccPjLll3yyXksm3o3h87AN055F1JE3w115wb0+j7XK2Vo06C+4
         E2GmHsfEJtYCjQazhR0K0mlBlU5Hp63fJ4N6PMCUBMms/1uWcUDiXDYCvZM0xim2Zc+W
         YIREJ2CxUdbY75dwXc0yZrBBCKRGcIAmSUG9MLtRDQ1ZAiPIcJ9ds/fi080XKYLzXzRQ
         ZCC1hF/tD3wWaPmjCXEfkuCgHw3ki4J3l8LXTMoqjs4eqowIe44Kvw8QQeZY1byDBYzu
         YBkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzxkQZ0F+k4m7lejuZ2/Hdgw0/mrgRoV9qdxxmjnxSWbUjmHbViXKL6L6PtHub/9inKi0LwjHYEAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZN5g51WMM0VfyOQZPjjcCd6kLsoswBYvyEV88VYLITQTX4WI1
	HObp6HH+JQmOm8yZeldrBQ594AKiaR9blEeMP6Rirr4s7ZqyNYcaaxqa7gQyu9d2iAdjS+BFHtM
	in3T3OOyyohWPxL6GJRahpIaiodh702tD/izvATlmNsKfxInnEXA4ZQi2wNeB/Q==
X-Gm-Gg: ASbGncsWnqy2oIm/vuAkfbAmEgEeo7xkUjUxOFbHAK0Ff6z0PTorUDG5kXdQnH0lyX0
	1NI6XRWOGLU/MvhzGbceWfgyWoX+1VouXNL/426uU1+oeH9qsywePyh+vwbMZ6G8sl7LfmbZSZN
	ssPlpEVJ+351BDdkFBTGqt13chTYYLjiFBnxteeIaATMmKLWeRykUizmlaZPbRlzqFBXnEsyuzj
	38R86rsh4QrbZJ37D+lA6E457+m3KhrE0MpU5O8+no0VGYgofqf86mHY+EwFjc5T4+4xJjv7Rsm
	H24R+Y+pmbQnYuP5np6p02vgwMc9UReI9tY1WFFI/KmjDvoBtbQ73kGt+Fsg++VRHu50CitS00i
	qgEzP/of1wg==
X-Received: by 2002:a05:6000:40c7:b0:407:d776:4434 with SMTP id ffacd0b85a97d-4241227789emr7217876f8f.30.1759332211759;
        Wed, 01 Oct 2025 08:23:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0F9XwtcVPf6wB/WoKqvKR5BovvccvzXbrj2loiPZ9rqJZd0tUbtbAeri7VVwEh087dav6lw==
X-Received: by 2002:a05:6000:40c7:b0:407:d776:4434 with SMTP id ffacd0b85a97d-4241227789emr7217838f8f.30.1759332211348;
        Wed, 01 Oct 2025 08:23:31 -0700 (PDT)
Received: from fedora (193-248-58-176.ftth.fr.orangecustomers.net. [193.248.58.176])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc7e2c6b3sm29483495f8f.54.2025.10.01.08.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 08:23:31 -0700 (PDT)
Date: Wed, 1 Oct 2025 17:23:29 +0200
From: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Paolo Abeni <pabeni@redhat.com>,
	Harald Mommer <harald.mommer@opensynergy.com>,
	Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com>,
	Wolfgang Grandegger <wg@grandegger.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Damir Shaikhutdinov <Damir.Shaikhutdinov@opensynergy.com>,
	linux-kernel@vger.kernel.org, linux-can@vger.kernel.org,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	development@redaril.me, francesco@valla.it
Subject: Re: [PATCH v5] can: virtio: Initial virtio CAN driver.
Message-ID: <aN1HcWZ4Q1lV+FdP@fedora>
References: <20240108131039.2234044-1-Mikhail.Golubev-Ciuchea@opensynergy.com>
 <2243144.yiUUSuA9gR@fedora.fritz.box>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2243144.yiUUSuA9gR@fedora.fritz.box>

On Thu, Sep 11, 2025 at 10:59:40PM +0200, Francesco Valla wrote:
> Hello Mikhail, Harald,
> 
> hoping there will be a v6 of this patch soon, a few comments:
> 

I am thinking to send a v6 that addresses all the comments soon. 


Matias


