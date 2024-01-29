Return-Path: <linux-can+bounces-179-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C198400DA
	for <lists+linux-can@lfdr.de>; Mon, 29 Jan 2024 10:03:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C43C9B20E81
	for <lists+linux-can@lfdr.de>; Mon, 29 Jan 2024 09:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C6E54FA5;
	Mon, 29 Jan 2024 09:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aqLZN5Bm"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A72B54F8E
	for <linux-can@vger.kernel.org>; Mon, 29 Jan 2024 09:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706518993; cv=none; b=CBjtaIM8fJ2eJ9KbooCZEijUIoaPQuLLoCM+7EGvO8JPMqpYHfa4EpIYVvBV22CtOtWisZMqDwomARg8Tm9Ikcv2VfIWIy7TJoe1eaGtzUWpt/bFE0aKsIYBJsbhVKfT89Wi4K52l8DDrKSRjxo0UFMKw4Xu4YwEcYw+Y41dmEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706518993; c=relaxed/simple;
	bh=1nON2OF3z5WLI3Czd8TXqDtjBnJ8MGSoCfcEuhxvlJs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fx+8jeQcn9JvRXtMdVIC9T+N/hJkmh/wTEvZYQUObK532fxA9OPKRUocAyoqAh3m2lQMTTPKPYi+NDz+OyYXljPRogcdYFdYK0DhAO3wtbkgxNqGIXP94AhjWLtmkhcIbRmE6T7BybIYogzYDZanIvMPq1b067kuDekF9Heo/tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aqLZN5Bm; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6ddc1b30458so2466581b3a.1
        for <linux-can@vger.kernel.org>; Mon, 29 Jan 2024 01:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706518992; x=1707123792; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dzt0hlczQx9Z+wOGy7gmUxquPbcx/ezUAu88iCy1ETQ=;
        b=aqLZN5BmHjpg6JIGCFJwM+toHnpK+wuzZ/t75WFlHaXLafEHN3AonzV7bVA00FYVtN
         HhLYeBHqtHECfLt1zRbWr9TJRIY5qkJB3v7GPVBUxmpcg0VjhYJfXZQFyLwhipPhw77u
         Vrh3+Zmg79RmmbUxN4Rnvk7i+UKyrd4kPx5bIMQe0vH1qtms4aWe8gjdPE06/bnOv5eh
         Rh0K+uuVNUo0/h+ycoy9Wnc1UOtntoS5evFChzj6ipOzGMGvQwjHFTRHSZsL7IifQVh2
         82Za3wTt5diHN8D45tOmCsmFTct00kDyK697l36fxEymCULROGcNZBZLLjDLrCtJql+Y
         1pXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706518992; x=1707123792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dzt0hlczQx9Z+wOGy7gmUxquPbcx/ezUAu88iCy1ETQ=;
        b=HRgOrvX1YTBpAiS66UUjygrFtw+n3Kig28PNjV4qzB9iBeitQGGtCcRUqNN/foe5Lq
         +I1FfuHZTRIXHjnupfnlKXXrDXbfkFEMa0ffZC8PF1+WV4eWstlCPtYlsR9wJpb38cP4
         Wn/hwLQ5zR9WoqdvULwx00vc8L+rD+E3OCE0Xe7hJg2c460WjbrQQfmFclUJLzHfzu98
         j2X5Wrj5BbKVWWS4QXSr/sjaJWwwFeMTew/S98b8b8ppLn8ax81/q4iCLn93YNqGHKse
         6TEVTMYhX6AzqyFoOhHGdVo/pSkifCMGSyQOxFWX1bcaHmwqiGJQCt2Bz6w460Fw7qBc
         mH2A==
X-Gm-Message-State: AOJu0Yy0fnCh8ObLKpM3x5DttOHgtQcCBKyL4PEr3e7zC1auSiYKYTow
	CZqJp7qnSLhR0DG3LO6vopkMgbcMiatT2+1oiIcXtYW3QdCvk/MZ8m/k7ucRxOwk+8Hbhi05989
	Qi8L0lKvO/PMNrEAwXdNvXr+LqPw=
X-Google-Smtp-Source: AGHT+IExi1LhKFlar3Bw4UfOIbwn2Ga2okZfqmBICCTOYXCAgtAb6YV/K88gIKe3NMiIkD4jtwgbkvUVb7yfVfnj5cc=
X-Received: by 2002:a05:6a20:4a1a:b0:19c:a980:58d6 with SMTP id
 fr26-20020a056a204a1a00b0019ca98058d6mr1283335pzb.2.1706518991614; Mon, 29
 Jan 2024 01:03:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <21323546-0ea7-4506-a1aa-62f52452a8c6@hartkopp.net>
In-Reply-To: <21323546-0ea7-4506-a1aa-62f52452a8c6@hartkopp.net>
From: Vincent Mailhol <vincent.mailhol@gmail.com>
Date: Mon, 29 Jan 2024 18:03:00 +0900
Message-ID: <CAMZ6Rq+5QGrVuKadhU8_=GmK+TV52fJaqRZYw9XQfUhc9xmDKw@mail.gmail.com>
Subject: Re: can-next patches summary
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org, 
	=?UTF-8?Q?Stefan_M=C3=A4tje?= <stefan.maetje@esd.eu>, 
	Maxime Jayat <maxime.jayat@mobile-devices.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Marc,

+cc: Maxime Jayat
+cc: Stefan M=C3=A4tje

On Mon. 29 Jan 2024 at 05:42, Oliver Hartkopp <socketcan@hartkopp.net> wrot=
e:
> Hello Marc,
>
> can you please consider to upstream these three patches?
>
> [PATCH v5] canxl: add virtual CAN network identifier support
> https://lore.kernel.org/linux-can/20240128183758.68401-1-socketcan@hartko=
pp.net/
>
> [PATCH v3] can: bcm: add recvmsg flags for own, local and remote traffic
> https://lore.kernel.org/linux-can/20240120081018.2319-1-socketcan@hartkop=
p.net/
>
> [PATCH] can: isotp: support dynamic flow control parameters
> https://lore.kernel.org/linux-can/20231208165729.3011-1-socketcan@hartkop=
p.net/

To add to Oliver's wish list, could you have a look at this patch for
can (stable):

  [PATCH] can: netlink: Fix TDCO calculation using the old data bittiming
  https://lore.kernel.org/linux-can/40579c18-63c0-43a4-8d4c-f3a6c1c0b417@mu=
nic.io/

and this series for can-next:

  [PATCH v11 0/2] can: esd: add support for esd GmbH PCIe/402 CAN interface
  https://lore.kernel.org/linux-can/20231122160211.2110448-1-stefan.maetje@=
esd.eu/

to which I gave my review tag in:

  https://lore.kernel.org/linux-can/CAMZ6RqJiCk_yc_V_1=3DTkJ41KjTQpDU--Z-kE=
wdUugoxMbz3G0A@mail.gmail.com/

Thank you,

Yours sincerely,
Vincent Mailhol

