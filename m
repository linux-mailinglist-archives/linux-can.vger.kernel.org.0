Return-Path: <linux-can+bounces-2360-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE3F09EADE5
	for <lists+linux-can@lfdr.de>; Tue, 10 Dec 2024 11:21:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 433E3284493
	for <lists+linux-can@lfdr.de>; Tue, 10 Dec 2024 10:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E991DC99A;
	Tue, 10 Dec 2024 10:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FapNP5AH"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FE123DE8D
	for <linux-can@vger.kernel.org>; Tue, 10 Dec 2024 10:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733826075; cv=none; b=QysxmehAV82xfU7CvPsMhWGKOrV4hfYIDN73R/M5ZCFxYufbSUBSLRAkPT7rmgEMB82tV34OLg1SMHcCIx25zuBF/LoDKoq04pkRMc4dZhhWx3ZllfTjnWdrs0R9PDrmdqveyqtJaKHD54GruAxyUhQbrzyoffEYMtDR9QFL/xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733826075; c=relaxed/simple;
	bh=2m6M5kFGVlj5uacbsTAQmLQ/Uw+TnJmyPuzEnwMziS0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g5+AsblQmGoULqgGcZTPrchWXCj6tX2uR0rAgdv7Qg+P9h56lTwJ/qiXAsiSc45l+Rhe/fsB93rD81mqbmEAekSSM0zJIwzWKIJvYOsyW/KGG3i4l4CgIVl6j/mWWGMQ6uC04I+ubXBOnKWA9vzsg6BuuDmPY5vNp1uasRLvUCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FapNP5AH; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-30167f4c1e3so23524271fa.3
        for <linux-can@vger.kernel.org>; Tue, 10 Dec 2024 02:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733826071; x=1734430871; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2m6M5kFGVlj5uacbsTAQmLQ/Uw+TnJmyPuzEnwMziS0=;
        b=FapNP5AHPUfx3SZwCcFPJKx0SWsxdIQ4F0Sj98AenoD2Yqpwm4MkDehWUotbHDi3K8
         tRdzZpwdpLsTZv73GmhZ8BGgvF8qkX3vCTYsSAoEZAT6JjRyNTjeCVAI30ABsu81zWJ6
         epnuRmPc00Xar1jj6BcTFPROGX7TjEnI4sxRdXgJWlAND8zUhPpTvMK/7d0w+RxqAlkD
         2oMI1nijEbbd/S/0EihkFk57Nuk8938WxRzgzgE2x3PPmTHwFbQxNg+8hgwEBiSQzvlm
         YSKVaSpy+AkisIPZh90yaN38U4cjS8AqfrXJM0pmNW0NHAMIfjm9VeHVOjf+M6Dqn4uz
         10cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733826071; x=1734430871;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2m6M5kFGVlj5uacbsTAQmLQ/Uw+TnJmyPuzEnwMziS0=;
        b=RQ6gj5vkGAID7IpTyWvFr0BcL9doRpPt7Q3Y9Ntzc6ws1JtUDqDk5D+w+NW13FlcCF
         +SSETt5bC+SGqeeaqTIoRFYlZsJLj80fKWVHqfzpgJGZ0gST8wX3u9Vg7r2a8DqzWD5H
         fYl5cu6z4yqxy/yLYL0/d7z4+pSZxIDEgLY+GWxIVZpcjpTfbue0fFczJ6FZCzSuBB7H
         2q6UlUCiILhxXqDopgnkn6qfBhWVKuTsZnVEmdc/guZKDaOYWp+1oKWKe37GmIUTEeKP
         qQGhL+fq5zCtJMR2ChcXfcJdBngl5DDD1PC+njPRdBrLGZK2OZ/8UxL0EHdirzBHxPT+
         6ayQ==
X-Gm-Message-State: AOJu0YxtJDf2KnZg1qrN2W0zqNce2NLfYorfjJTSlXDF5yTCaM6GZU3+
	P4ZT39OjY8ySfDenA4Ai6qvol45OsCvsznT5U94sanTaToBsH6q2PaX31XYTXYBW/ZvKQi4Cxtb
	S1Lkkf+Ai73o3n/09xvfGgENl6ps=
X-Gm-Gg: ASbGnctZXym7cM615JYfCafpWjrf3YwEcHGt+6Ukc4J6ja/Xa3HTd0XJvdAa6cqPT8O
	6DkUJn304v1MnbOHkEE/2p8TycAIyU+x871c=
X-Google-Smtp-Source: AGHT+IHVUyVstZZ/fTLe00dvqp09rbZJYTj0/GWgK24iPuuDyIdjL1K0Z49E1rqgrQ6jnyI0yuJB8Wq1GfNTSPGDyAM=
X-Received: by 2002:a2e:2416:0:b0:302:3534:1fba with SMTP id
 38308e7fff4ca-30235342109mr6126781fa.17.1733826071297; Tue, 10 Dec 2024
 02:21:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+VHkVF89EZOtnqWFGfS4JFtuLdkX2uJNwY7vicJ=i3RiZtbZw@mail.gmail.com>
 <20241202-organic-caracal-of-skill-4faeac-mkl@pengutronix.de>
 <CA+VHkVHhE5tT6D60MJadVvJ1nvM9gK2kMmZYD_MRP6iJF89pYg@mail.gmail.com>
 <20241203-frisky-badger-of-fury-8c68c2-mkl@pengutronix.de>
 <CAOv6HECSnL-pqo9e9i-_90LHzipcz+Q7e7J+H=ZA8c8rtQUTEA@mail.gmail.com> <20241209-quiet-steady-rottweiler-976abf-mkl@pengutronix.de>
In-Reply-To: <20241209-quiet-steady-rottweiler-976abf-mkl@pengutronix.de>
From: Stefano Offredi <stefano.offredi@gmail.com>
Date: Tue, 10 Dec 2024 11:20:59 +0100
Message-ID: <CAOv6HEDpGL4WPnFt4L_9ioq05WXTYLkGMP_w51GZ-e18=f8Hxg@mail.gmail.com>
Subject: Re: ACPI compatible mcp251xfd driver
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, Stefano Offredi <stefano.offredi@daosgroup.it>
Content-Type: text/plain; charset="UTF-8"

>
> The RX-int GPIO is purely optional.
>
Ok, I see it from mcp datasheet.
But even If the loading works here: devm_acpi_dev_add_driver_gpios(),
- that should be similar to your devm_gpiod_get_optional() - then the
function 'request_threaded_irq()' returns error.
I'm investigating it.

regards,
Stefano

