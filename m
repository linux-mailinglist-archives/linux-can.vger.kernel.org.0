Return-Path: <linux-can+bounces-1208-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEEE895B2FF
	for <lists+linux-can@lfdr.de>; Thu, 22 Aug 2024 12:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59C311F23D7F
	for <lists+linux-can@lfdr.de>; Thu, 22 Aug 2024 10:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12BE61836E2;
	Thu, 22 Aug 2024 10:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kc6eurlU"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A3917F394;
	Thu, 22 Aug 2024 10:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724322950; cv=none; b=uT8O1I6GX8yJD6wVUDsG1m3+E3WGhuEAte2JJk0Nt3WWa72lhnBkvIYJ79HXoMa/FUd8UHE9LdUW+xqbjIO8x1W2jvb7GbbQGFJn2zq2zBn5lTzRwY0NHR3WqsciDLi6uyfkKLBl72+fMz1FmQD9iXzUOBbzMryGiSeZ6mja1nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724322950; c=relaxed/simple;
	bh=tJ6slw/6kOjVIC0oHyt8jBPYECgTa6zFYfoO0kMdIcA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=txKLty13q7YKqdXg0RODcu8ROYEkRgHDQJ6ezFw4emOFozqh9EyVNbpAl1KEMpOsvJUVc2ZXzkdHjOkB4lbFgG8wMkhJ63smIGm3DOiXGIqNuXwCxaNNi9ewzWf3QxVdwst3RgOuDWtdbUDY1XXx4jbcxe6Khgi3+do7h2p+a8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kc6eurlU; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6b4412fac76so6270037b3.1;
        Thu, 22 Aug 2024 03:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724322947; x=1724927747; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SlGOucvSgDtSQ9wwuPYvLZJURsS0vqWONUgEBulumIA=;
        b=Kc6eurlUOPgfkYTP9UhFOYMm4nuezGdTAO5t6kxhnHKXpSBfS8mILQov3zT5J38KCI
         u7PewuJlUHhotFaSYtIzoRAN3wRfM5XjvPmDV9QafOVCGL0OFOO3cTPMJvnbKok7dHoY
         /+v7vOW7LAc+BdsA6tZo1Gp/ir/1xsc9hqk8QCOwhWxM57FxPMX2DDkb+LrdwCt4IRAv
         4Kt7OTs6PZDKAU1Ep7bqAM+d3L6mrDADrWGi9tyXuWn52GPmPWJE72xhjV8hxVd5YPpr
         Ymi7+kL1Yl1If2UfAWLaSdMMLbMYmWKGTZPfMr6l3os2Iqa2ymgyrYivil338v6TmMxK
         srTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724322947; x=1724927747;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SlGOucvSgDtSQ9wwuPYvLZJURsS0vqWONUgEBulumIA=;
        b=MLkXdoTMXul4bAt1Gv/UmRzBP3InJCN952oyfsRs1/KzCbuK0YPuIEvlsl4rW+XkUp
         1ng2RXfWORbYyLcElKQdifq8/7a8266Mg9PuCqqCmR8jTp6LVgmS4si6pw9KOI5LYKA4
         O5bCEgJBusGnEeNurREwbsmjc+g7xN82oUAEb/h2Ciaoj5+sIq7TIxpQ6C5FVXJNJTZm
         ECq2ANs0CM/OhyvBHyer+z7jvDlEuxdA3P9F3VwfoJ4v1poW9f3JWMyA6X9XKxGZnJGm
         UPfbVcKgJCTGxJo9RFbQ2/TTj1TyJEQvaS3BOSdJG07CI2KJmQDa1qoPu61BxE+X31/E
         wCPQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4C2RrN73WxrjKvBEOb3PZskINzoIEt/yHXEXfNtILUVke5GVh+KEojjkIPndn9LAEzNZs4Q1s5pOB@vger.kernel.org, AJvYcCVCJGpEZgLCD7f2b3U7NOPakf0Gu7+56p2kMcJy8UerJbIOhOvQrKvyaa88XEu0cRdRTdaM+nwCGi2H@vger.kernel.org
X-Gm-Message-State: AOJu0Yygs/Rs7NppqBPhmjFHk1cJqUI9GtKTtTFElDd0emd9npmcP96k
	LWXfbNqYTWXomWlhwItDYPYlY4Wuxo0q32ZhRkGJVGqAtDjrKVtT5PbYwQKyecATnGDsVk8d1sV
	Im4GyD5y8I0gay9TIPsi8kejpngo=
X-Google-Smtp-Source: AGHT+IG6bWOYEN2J3a92yRl68xajoh4axN8so4QLGPSZQq9BbWbUuCUj+XIS5c+xCT5cUK9sMjHDEY9agZS5+hY0dUI=
X-Received: by 2002:a05:690c:3744:b0:6ad:219a:b687 with SMTP id
 00721157ae682-6c3d5ecc2d0mr18942827b3.39.1724322947525; Thu, 22 Aug 2024
 03:35:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240821215357.20224-1-ilordash02@gmail.com> <thpryn4unrebkvx4a7jhqmxt5ntmog2gcw3ekh6h72jews4een@b43tsg7poegn>
In-Reply-To: <thpryn4unrebkvx4a7jhqmxt5ntmog2gcw3ekh6h72jews4een@b43tsg7poegn>
From: Ilya Orazov <ilordash02@gmail.com>
Date: Thu, 22 Aug 2024 13:35:37 +0300
Message-ID: <CAGCz5H=vos9sh_ts_ExH8dQSnicFyN+=TfWmBbnqS8egdD+k=Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/1] dt-bindings: phy: ti,tcan104x-can: Document Microchip
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Aswath Govindraju <a-govindraju@ti.com>, linux-can@vger.kernel.org, 
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 22 Aug 2024 at 10:09, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Thu, Aug 22, 2024 at 12:53:56AM +0300, Ilya Orazov wrote:
> > Hi all,
> >
> > As suggested in the previous email conversation on this patch, I am
> > sending this new version as a standalone email. I hope this approach
> > makes it easier to review and keeps the conversation history clearer.
>
> Where was it suggested?
>
> Best regards,
> Krzysztof
>

Hi Krzysztof,

Conor suggested that I should not send new versions of the patch as
replies in his mail [0]. So, I sent the new one as a separate email.

0- https://lore.kernel.org/all/20240809-guru-tassel-84a14486a596@spud/

-- 
Best regards,
Ilya Orazov

