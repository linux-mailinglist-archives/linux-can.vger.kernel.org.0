Return-Path: <linux-can+bounces-4185-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7900EB1360D
	for <lists+linux-can@lfdr.de>; Mon, 28 Jul 2025 10:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B309D18987D9
	for <lists+linux-can@lfdr.de>; Mon, 28 Jul 2025 08:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFBE621171D;
	Mon, 28 Jul 2025 08:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="tDzDbQNq"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49F6188006
	for <linux-can@vger.kernel.org>; Mon, 28 Jul 2025 08:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753690022; cv=none; b=GG1XixDOd5a+ZT34fp5BVo7EqnxRG/w1c0YashO9aLP6YAjknjqFiQwiow/C3arMztsH2uNeFHmltbn3giNvyrRqgrsi4qdII+1uhzydM0yutJ35xaUVYW5JWdh3sG/jwK82Y8a13uDt4Rp2pNjYK1CTK4IIXzfN9oSr2pafask=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753690022; c=relaxed/simple;
	bh=il6F1V3EZvaPgxXuexkA60ipkgxSFbEms1cYfVuykjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iFpLExZSWtDF9uerN141qeNY1+eJgf3TzL7zNtYIQXAWrOR6QFS6SkxScVlhONDjMkb/SM1CUW8DiVg4x1M0l966FUOjIA4Rof1eB3k+rAIa62w3lfI87DzGOVc8bYoqVN/0urqFENA6hoRjagUduImTjE/0B98MUdIgQjl48Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=tDzDbQNq; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ae9c2754a00so838128166b.2
        for <linux-can@vger.kernel.org>; Mon, 28 Jul 2025 01:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1753690019; x=1754294819; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pEoNvXLK4SEQ+X3J17Qj8vDT7ozZpc00fO4Rtvit2Lo=;
        b=tDzDbQNqOgAdBHLygZmJhm1HkFQrsVF0T5czwpZyMaHtCOJFylqaxVEBsugghLbJGt
         qtcicVTi+RwKNBm2y6rEXBFRM1m9/lGm2Txu5p8TbySfhlzqQLe3jgqdNL7yY7DqFCk7
         Rs05CI4AwN+qV4yj6/MyyKJ9KLSC4Lck50RR3qntJV6g/05eRNbpgLLjwmoYwlpVWNDC
         N2+KKNIE4qKwiMQoW8lzBC6CPDNFsP6Nlss75eQ//8pMC6FpKfR+u99Ms9crBSzyn2Gs
         QZpVCws+ETv+k7AJGYP5S89mB1+wda9qXe6DsL4Ar6fwe8ybUqObZDUBYhJ7TfJCzPiX
         R3xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753690019; x=1754294819;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pEoNvXLK4SEQ+X3J17Qj8vDT7ozZpc00fO4Rtvit2Lo=;
        b=Xvk20K+AUuT3KtIsPAiAqOEVXNCdMFNG/D+J2XhqHZRVo/s3A859Berjvzr8QoFO/v
         UqyhgCaoGbWNs1aydet4gwyGtG2Lndf06Ih9TpW+PvYwnrNbP0+LjfVaZBZV3pqf0Wqt
         KNwF2hnJ22TFsAmdJmBA9U5OMQgZQYqZ3RVh32JkP8xpLS2Owv33PhvmNzPCyYG/m/4T
         Bjn0Tk62tur7eLO++T4+UXDhu8KHfxGM3MaeNsFEB++FMM/TzjwERqv8Qcldr5fz5ieD
         mwxSID2WRDz3aYyLJ2lLWph7YNfJpVMBL/2j1MiBZBTNvY7fR583qGbqDd7y1S9TZ4PE
         PKAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWO+QOMhgBTahExDyK80LFPjYSzNdknQZgfTGmNzgACH7hRe3s5pPwfbVjH/HfPHP3JqL74sD4tQ8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YydfqVUxae7QOwt6SboOrQiIqeAL94WEwOKTj1nOikbYOW/2sAM
	cI52DCxPUSC4YqQMCMQkDq22RMvuYRKrHwMBvZpAm7JdNDBF9ALjoKhYTX+3askrwQo=
X-Gm-Gg: ASbGncsUkyP785RplihgfckRIc6bKjYkmq7VLTHdwQFmAbHKEG1VAa3cK7BlsFaON9C
	BQpjcNx7iOB4UFmL07lUQn1KaCU6TUObREOfzV46hwD7q+8M5QfhuHga7SqK2/7ZeH/8rUfofc9
	mgVqNdTIIED1kVIXePG9QfDqQ/xt7XMJfhAXYLeMiLDeT4FISHPEFBEFx/3Up1SOBHp2aaOy82J
	lkJRBVtcKhaSz3KpdndpM13oFaHC9xj6frstHzaMAIFJo6E4O8RIt/QAavJK8AUId4sV9xFkmTC
	YfirmwPtnobf8RVsjRmJen0U89xqkJMND+PsM9kmGPEroiqf3acx/z4PRgTx09ahLB+pNFtlHwo
	pwrUDVQWRjAfSNgY2ZW2hDUYQGEcNHW29ae1zkaQ=
X-Google-Smtp-Source: AGHT+IERxblnoOCYOHAQiO6rqytlBsYokSKccm9wl4WU+Wi8aQMeTB+VQcGSWt1hqYjD8PuGuUuIDg==
X-Received: by 2002:a17:907:2d28:b0:af2:5229:bd74 with SMTP id a640c23a62f3a-af617d0491dmr1281521166b.26.1753690018504;
        Mon, 28 Jul 2025 01:06:58 -0700 (PDT)
Received: from jiri-mlt ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af63585ff45sm391864266b.5.2025.07.28.01.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 01:06:57 -0700 (PDT)
Date: Mon, 28 Jul 2025 10:06:56 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	linux-can@vger.kernel.org, kernel@pengutronix.de, Jimmy Assarsson <extja@kvaser.com>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: Re: [PATCH net-next 26/27] can: kvaser_usb: Add devlink port support
Message-ID: <hjhpopnmorqqo65mw7psmlzmqvzhn2d6x22y2aq5miqsevdkmi@oak2s6kxfght>
References: <20250725161327.4165174-1-mkl@pengutronix.de>
 <20250725161327.4165174-27-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250725161327.4165174-27-mkl@pengutronix.de>

Fri, Jul 25, 2025 at 06:05:36PM +0200, mkl@pengutronix.de wrote:
>From: Jimmy Assarsson <extja@kvaser.com>
>
>Register each CAN channel of the device as an devlink physical port.
>This makes it easier to get device information for a given network
>interface (i.e. can2).
>
>Example output:
>  $ devlink dev
>  usb/1-1.3:1.0
>
>  $ devlink port
>  usb/1-1.3:1.0/0: type eth netdev can0 flavour physical port 0 splittable false
>  usb/1-1.3:1.0/1: type eth netdev can1 flavour physical port 1 splittable false
>
>  $ devlink port show can1
>  usb/1-1.3:1.0/1: type eth netdev can1 flavour physical port 0 splittable false

Looks fine to me. Out of curiosity, do you have some plans to extend use
of devlink port in the future, or this is it?

