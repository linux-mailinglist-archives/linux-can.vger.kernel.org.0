Return-Path: <linux-can+bounces-1195-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6839595208D
	for <lists+linux-can@lfdr.de>; Wed, 14 Aug 2024 18:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 253872823DB
	for <lists+linux-can@lfdr.de>; Wed, 14 Aug 2024 16:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95131BA892;
	Wed, 14 Aug 2024 16:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g0lMGtmi"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7B61B1409;
	Wed, 14 Aug 2024 16:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723654604; cv=none; b=uA3lStdSP0U3cidJCOaVdpLeIRT7vlq9xhXnXAML8/BHsBq7ESUC3UJNrwhHjcP6MXe8M/61mSYxJJb8hlDB8/iNsASEF1W4p5KbL0tKMZmUxdcKYAGT3BdLrWy0mr0kCHXkothi4cIhup0hGYNLRb2RWt9xhILk0NrcJuPKE8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723654604; c=relaxed/simple;
	bh=/hZxRpWjkSzm+b9woTEwtKZS/63L4EVOkAp/S/3Mvls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FHUTtCzG0S+H9mp2GToUyOKkHchJluUHKYL8Luk5F5kGIiyQV8BQpwHnL0SyxmQZnSdRWqrFBHI1pPS80H6qV8Ik6pB3o7Lu8k9uX9BpR28Y//BzqAjoPUgFnipLJVaeWsBX+wY/1rkn2MoHDnJJ0LFSVvC36YIaTJi8c2qXjJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g0lMGtmi; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-664b4589b1aso9569657b3.1;
        Wed, 14 Aug 2024 09:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723654602; x=1724259402; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qQlMOc1RXgEI/Z1W2yTdzy+viQNXziUCoDnFw4tQg7Y=;
        b=g0lMGtmi498WXdkfH/EeXYFIgsysjPryYcTd+K2msFvwteIugOWEjNAOykxayK2gLp
         rcXVfJFVyC+snFu2+GtNbDyQag3FRh8xONNCRr/gJ2ns2n5N8Hws651A6TdRYrtscCGI
         jI10X43tknp7N3PDX3KhF8l+KNMX9boThZ1tZXuRm8DaCiTZ9YtOvJzQLWuSe32am1it
         TVxSPyD2kLQPO8E053rmuO5CZOqvt9WUPHRJFeDS8B11TKkmB5rokPsVgzllzDyjqae8
         rJASDXxwJoNPFePQmbA/R3b+uRz/cn2S5HtO2iOYw/TyycqyQypfgIZUTvdFU34sebOL
         X5wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723654602; x=1724259402;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qQlMOc1RXgEI/Z1W2yTdzy+viQNXziUCoDnFw4tQg7Y=;
        b=v695Ht3i80zPlF0BCIWKWc1YGj3ekkxZ4Sx+Ilnzj1BnI3YkOFUpHm4BCixgM9i9f2
         PPjrxZ9N6PwbeoxGH/54jvY4CSM58nrbAXu75L57wyCwyApbvrvhCSLNH3G9H6AkmyM6
         pPJ4QKkXZ59QcZn8kwZDoFeDfvVx22LwGFLgslzRjU9X8W0NZMIbumsLp6WddEI7h/bn
         oc/hoAJtKEwK249FTycMzFN+XVPqFUbnhEUbym+epDY7O8uP93k7n5Vqw1RsGd1HWYD2
         EMc/4Q6aWZj3MvWSt8E0q56GFepEP1h3LWfAWcD1LVrWhCSnrZG2khyk3OuEFThz67ne
         n99Q==
X-Forwarded-Encrypted: i=1; AJvYcCV0tK3AO7H8HKIis7/Jbc8cLo/vSTLSmyVSPGF82MSuJ1o1QgsyINFUKCwVj3JpuP1Zc4G8keoR2W4AeTUVFnTfNpr7a78yrtctTmVOZPa4zCVPX+NfQMSliz4fRK3YIBSvMoiZ2Q==
X-Gm-Message-State: AOJu0YzoylkqISwOZS65QA4cYlEdU3/fahkCYNXDjioUm3gxCunxqXTy
	CTXN6QQx0920duHQXnIIwqBMsK2Uj6lUJiGDk8DHj/Vgs9hEpiQ3lUWiIGoC56yXcJxncmfTwyX
	8MGiphR3m+WM8Dw8Z12/e0mcTlTY=
X-Google-Smtp-Source: AGHT+IFITVwqIytbC41TtrGUFCTh1I6Ia9wAgWzzSZsz2WvL3UAmAXNXWe+UUoRM3D9mPKUYr1j8dRhQbEs79AGlMmY=
X-Received: by 2002:a05:690c:4e0e:b0:64b:82d6:75b9 with SMTP id
 00721157ae682-6af1c990341mr2123607b3.7.1723654602276; Wed, 14 Aug 2024
 09:56:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <56a52c81-68de-438d-94ae-9decc799d824@kernel.org>
 <20240808191735.1483572-1-ilordash02@gmail.com> <CAGCz5Hk=mSjQ1eFWstQQu=JZUkavJ_mRhnp8DRELUXP_syq4Zw@mail.gmail.com>
 <eb04b684-eccd-4952-a310-022d00b50a55@kernel.org>
In-Reply-To: <eb04b684-eccd-4952-a310-022d00b50a55@kernel.org>
From: Ilya Orazov <ilordash02@gmail.com>
Date: Wed, 14 Aug 2024 19:56:31 +0300
Message-ID: <CAGCz5H=n_OOeTTNon2f=D97y==ysgXMijCkB5Nb2XVTDTQ6i4g@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] dt-bindings: phy: ti,tcan104x-can: Document
 Microchip ATA6561
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Aswath Govindraju <a-govindraju@ti.com>, 
	Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org, 
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 14 Aug 2024 at 12:03, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 13/08/2024 19:14, Ilya Orazov wrote:
> >>    '#phy-cells':
> >>      const: 0
> >>
> >> base-commit: 6a0e38264012809afa24113ee2162dc07f4ed22b
> >> --
> >> 2.34.1
> >>
> >
> > Could you please review my patch?
>
> You received review. Why do you ping after few days?

I have uploaded new patch version and fixed all dt-binding errors, so
I thought you might want to review this updated version.

-- 
Best regards,
Ilya Orazov

