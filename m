Return-Path: <linux-can+bounces-2354-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 904A69E9B26
	for <lists+linux-can@lfdr.de>; Mon,  9 Dec 2024 17:02:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E55C9281076
	for <lists+linux-can@lfdr.de>; Mon,  9 Dec 2024 16:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E631280034;
	Mon,  9 Dec 2024 16:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nft9K3ck"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2818923312A
	for <linux-can@vger.kernel.org>; Mon,  9 Dec 2024 16:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733760117; cv=none; b=BX74/w7M3KxFG2csVlLsfV+FzOH7HCDo2D5lWftXYRySekz6BIFVtniFzkd0eTiP/rkGyuW4wm0KJPK0/G1j3IBhuKZjQFWlkU17DTGYBP9V4C280PS0MUG3FBcBSvsyVhtTOxkmzbZs659sohHM/rkqPUErXSa5RD1AYvF6Kdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733760117; c=relaxed/simple;
	bh=Szt86YIjLHSi0XOhrOpvbaoBGVt053WnP3QU6c5sW3g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SyaAHkbJD1ON1DANac299H2JbmZ5hPozBMFOTn2+5iHpcs6N1VbMuUsu21pvw6u5uFGICNr7yytnY2b+/d8shIQ0zl3PnxHTU7j92buzuB9eWLSrLWo1O9EeJ4FRe40Bf36HV0f01px5z64nAXH4KJytpZNLUWll24944rsGsYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nft9K3ck; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-3003d7ca01cso23034321fa.0
        for <linux-can@vger.kernel.org>; Mon, 09 Dec 2024 08:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733760114; x=1734364914; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9BJkly3rkVJ5/yzqQHG5Jv4U1V3l6gJNEVweTcQnLII=;
        b=Nft9K3ckNCM+7KqGFXSdTIClWanyiSXxXGuvf8y0M+8HpzPGZq8dXH1HeMu7bQReCk
         cFx6WwdpHxbv208cppSN3HHM3+jybxZSCV09ordlsPwQeZDGRMHluMHB8h+yVeI3amth
         ySJE23sY8IPHyO60Da9tLj725PdKaTkDhGe+tx89I5sReNFa+10+d3KG5jyMvpCoU0To
         5yYmhf+t1ORaTes/ikj89beF4fVqRgWXjPtobK28GO2C/O/fgHyfYxRhq0IIiy03dg3A
         H148Iokp3fWIT5p6ba9rE3jj9xjOqx85GzWod0Jysy7cabks3V+GRZLidlbeGFhtxork
         ZcFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733760114; x=1734364914;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9BJkly3rkVJ5/yzqQHG5Jv4U1V3l6gJNEVweTcQnLII=;
        b=YcvtycboJaZgmabiF44zi3OMB9aZikSBVZ1Lk/YT95Uda9uNlk47Zha/y4odRhl8zp
         G7TZtiLTldVtAhU5gQ1O4V+r19jFPLKJx1DyLRsbD+JRQ+aNwEQmHFWs+KQyZOo1oFCK
         MP8/GrbeoA5D9DzfGdGbl/c3cFGck6D/wNMWf8V8T0nLDIvi2o1ju1kIW8DJbeHf1ThW
         Z0eWYlI5bRtb8Of/ZhyoAdtXd3EZ8Zp4JAF0t3n5PFEipzCpGIT2mE+AqQa8PajIw2Zz
         nOPm5jC0arRoWmIQMXIRDNPP6d3Fw2SjwpDAz0KrH9PnmfCrQxGIueTvUizG68j8f/1R
         yLCg==
X-Gm-Message-State: AOJu0YxG86gU/31Bh40EiV8ZkjIYesrvTGNEB2uFf67gOUolcj46jHH/
	r+JEU+n7aNSwnhwiRPQ/DJrZmUMr/w1udxn1SeZj5Xb3MFW2JzrrYFuaAfx20lJWGILLurIzcUK
	+Scm+jKfRRlvECRIZTF+3cL1kEaRNEyS2
X-Gm-Gg: ASbGnctKVtgkbMX550OVYvMF1xf1DLcx2QtK9BWVGT+kRuNGD2TYriy1uzo5GiPcNy1
	sQT+OjqbrEcSN4PKLvwXGHRcLn/4NB7Q=
X-Google-Smtp-Source: AGHT+IHnHHAJyFlC9A126nTCnGjRfnJr9Vxfs220UvMhxn8pEIldQ13uBfi42VE+ObFHVDYql5wBC1/jLWVGy2nrRIc=
X-Received: by 2002:a05:651c:901:b0:2fb:407b:1702 with SMTP id
 38308e7fff4ca-3002f8df31amr37347761fa.20.1733760113453; Mon, 09 Dec 2024
 08:01:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+VHkVF89EZOtnqWFGfS4JFtuLdkX2uJNwY7vicJ=i3RiZtbZw@mail.gmail.com>
 <20241202-organic-caracal-of-skill-4faeac-mkl@pengutronix.de>
 <CA+VHkVHhE5tT6D60MJadVvJ1nvM9gK2kMmZYD_MRP6iJF89pYg@mail.gmail.com> <20241203-frisky-badger-of-fury-8c68c2-mkl@pengutronix.de>
In-Reply-To: <20241203-frisky-badger-of-fury-8c68c2-mkl@pengutronix.de>
From: Stefano Offredi <stefano.offredi@gmail.com>
Date: Mon, 9 Dec 2024 17:01:42 +0100
Message-ID: <CAOv6HECSnL-pqo9e9i-_90LHzipcz+Q7e7J+H=ZA8c8rtQUTEA@mail.gmail.com>
Subject: Re: ACPI compatible mcp251xfd driver
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, Stefano Offredi <stefano.offredi@daosgroup.it>
Content-Type: text/plain; charset="UTF-8"

Hi Marc,
> Can you share the modifications with us?

Yes, Now I will send the patch I have done and tested on kernel
version 5.15 that  I have on my SOM.

> > Now I'm dealing with a problem in bringing UP the can0 interface with:
> > ip link set can0 type can bitrate 1000000
> > ip link set up can0
> > RTNETLINK answers: Invalid argument
> > ..I'm debugging it.
>
> anything of interest in demsg?
>

yes at the end it was a problem with my rx-int gpio, that was handled
not directly by intel chip, but with a gpio controller in the middle.
Now I'm able to bring the can0 interface UP.

regards
Stefano

