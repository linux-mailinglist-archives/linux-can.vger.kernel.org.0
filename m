Return-Path: <linux-can+bounces-1914-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E6A9BF08B
	for <lists+linux-can@lfdr.de>; Wed,  6 Nov 2024 15:42:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16C061F229D6
	for <lists+linux-can@lfdr.de>; Wed,  6 Nov 2024 14:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4611DD871;
	Wed,  6 Nov 2024 14:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Shsw/FHq"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD898C11
	for <linux-can@vger.kernel.org>; Wed,  6 Nov 2024 14:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730904168; cv=none; b=n33d50exji6nuhq0ulive7P2c7Gpse46HJQhdNB0UxpHZym5ofzCPQTzVJmQP0pZqC0c4VNT41EzQcmaeiZLpoweB66+WpyNaPyKfyCYkKCsoigsuuSj3TJxSscY26cyozAqF5RodHZHUnvP7Mkgjjz4OslVV8jp+UnfsaH0aXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730904168; c=relaxed/simple;
	bh=w/T12pLrwFekZWLQkG6iXZhkqC5oOjo9r+/EsD02cbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JCp1RWaqqg7h4B/3PQp5YPsW2pjBz2DihKNfTzWLUOMuCvWLJ0zjttooRbZ2Q/bDRfb96eFNCb0TcUzzSmXIOzlR58Z7RMLwFSoEL85YbfWhEXQpADeu2uh4Ii6ipLzTz9oJwVU/lAE9eTzxNyFgYN7N/Y97kymG6VMMAa4Amnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=Shsw/FHq; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-37d808ae924so3830759f8f.0
        for <linux-can@vger.kernel.org>; Wed, 06 Nov 2024 06:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1730904165; x=1731508965; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w/T12pLrwFekZWLQkG6iXZhkqC5oOjo9r+/EsD02cbA=;
        b=Shsw/FHqykzb9/TAa/qGv9JVgnWWcyLjaif7ssChVGJWyW1eiAM1f5uo4qwdC9yCgT
         tEQ+chfsf77XIfxIb0TFuDCtcQxjtxtaJPB1ml0O0sr5q3gfAkj/I1gvjoHgAqYoKgLr
         uz5dxbZ4WBkg+iKzctNVmrtixGHSYCas27LqDdUXzulqsTjjLOKA+3RliTFzJmywrcYO
         MzvRk7A2wOQ2aoUW2pJWkVPpVaLe+s7YvsWDtJgy7ig8gjjcto4UnMtRiYu8DB5wHgGU
         ZboNLostMo+O7Fqm/cIfwBydT68Xcyz6U46LR3nGuvs1i6IvO2cYege/xHj1GdKSTHdF
         q08A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730904165; x=1731508965;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w/T12pLrwFekZWLQkG6iXZhkqC5oOjo9r+/EsD02cbA=;
        b=fS8VsedJoYVioD68ON9BqzTzNnf4SBeEP3bCuSoICQW4jNQsdLFAukfr8GVoTAEu/h
         es9/1UfqK+RfqCLI5uXx+0Ecr3Xe+eZ2RkE17LZpjGujVYFw8JTRqYWPRsZUkmevkD12
         INzgMY8kyYX3kpsZ8E/Dq3p4nzjs6URkP2tUllSz+g+mVdLg3suHbnR7Cg2hH8X5b12U
         fBgJUHn43opTe4SS0pAPgF36/IxBHuJ3FlVjR1eAJq8WNhKDg9JSkcybqMzISzccYy6U
         9GbKKj+EOjdzkRZNiCRdKgcb9LUbLgJOxyjoiPul8wrAhuF9bN+vNJZqemquezqI0D4/
         gLcQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+sWB7yKZtu/Qgiyhqw9ZrmeVAy5g9LyncEihyDiW9L03Nqo3P3bJE27ss46VPjQ5JRz+rVS7JVCA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4s4m0zC0PKcDPDYX5GiVJ/6SU8dLdre6UklM8dPo2ye6Ogkm4
	/lDLndUdiF8feRf2Uo4+yZ3ooiL3ftxc9+3VmiAM9DKbMKmDtsBiRHgmgoH0C3U=
X-Google-Smtp-Source: AGHT+IEj7DDDgjJGqjAL6G6ehbFSukuRXVP5DKSB6trScqHTBzKbKGL0RNb9VtHv3hM/eCB76xhdZA==
X-Received: by 2002:a05:6000:68a:b0:374:c8a0:5d05 with SMTP id ffacd0b85a97d-381e18314bcmr6108769f8f.50.1730904164884;
        Wed, 06 Nov 2024 06:42:44 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10b7bf7sm19642445f8f.9.2024.11.06.06.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 06:42:44 -0800 (PST)
Date: Wed, 6 Nov 2024 15:42:40 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Robin van der Gracht <robin@protonic.nl>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
	netdev@vger.kernel.org, lvc-project@linuxtesting.org,
	syzbot+d4e8dc385d9258220c31@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] can: fix skb reference counting in j1939_session_new()
Message-ID: <ZyuAYISuNQh1r7Ni@nanopsycho.orion>
References: <20241105094823.2403806-1-dmantipov@yandex.ru>
 <ZypJ4ZnR0JkPedNz@nanopsycho.orion>
 <9393e900-b85e-428e-a2b0-9e3650b86975@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9393e900-b85e-428e-a2b0-9e3650b86975@yandex.ru>

Wed, Nov 06, 2024 at 12:03:57PM CET, dmantipov@yandex.ru wrote:
>On 11/5/24 7:37 PM, Jiri Pirko wrote:
>
>> It is odd to write "I assume" for fix like this. You should know for
>> sure, don't you?
>
>Well, the final vote is up to the maintainer(s).

Vote of what?


>
>Dmitry
>

