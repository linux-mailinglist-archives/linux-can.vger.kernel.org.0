Return-Path: <linux-can+bounces-1407-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB90796C3A9
	for <lists+linux-can@lfdr.de>; Wed,  4 Sep 2024 18:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 847B11F24650
	for <lists+linux-can@lfdr.de>; Wed,  4 Sep 2024 16:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8331E00A6;
	Wed,  4 Sep 2024 16:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="UPRU765+"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30741DEFC2;
	Wed,  4 Sep 2024 16:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725466407; cv=none; b=Jz+/T3qcg2MvSWAL+ZRtg3FijgYJvzyoGcW+3qpJoaLchRqoMK/NmBCPW3ADr4qEzfRxkvSUWvP9bheE/1RqJEHzNuYwZE+MGiqPyCY5bfYWgOr5nzUuZPaqCCoWY26e/PZP6+6o141epDQtPwG3wvUwwKVVPozY7vp43eQXXgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725466407; c=relaxed/simple;
	bh=u+KeQ7XnTBV2WaOnAo0adDENVgOrsRCd5/2OivjahVY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lB0R37n3cU6RY26/iVZnF80Z+lsfot0JKDPpJKdQR/TKqsdtmhNRzhP1g1mdbDZAKl1Y5B+omKdX+iu/DxXgp7HXKg18M3N18E/FqxrJp21xVG6NjhOra190T/kBUwGcXECsEXs1BcGHu5WVV2der55LYZbIOMAmk/rZ4JWaILo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=UPRU765+; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-374c180d123so2389891f8f.3;
        Wed, 04 Sep 2024 09:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1725466404; x=1726071204; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:reply-to:from:subject:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u+KeQ7XnTBV2WaOnAo0adDENVgOrsRCd5/2OivjahVY=;
        b=UPRU765+Rmm5tQJEeO4GzqSFYoBhcGeuLkPFuUfmF+qnG781y2ZzSbftpl45RwpSou
         gdQbH6rBPLScQvxfTIFlsYMyPiDLfs0K2q/7ZM4K+UeXCjW8+wG1989ew/2VBa9vETaq
         Zv6M1OSypliUYsU77mEqsje54/Sn6oFmZroRjVv6P1h9I78Z7Q7gG8vPbYQVH2oOvfPp
         pTyWKa/Efso9D+QjMJzEfygdQ1WWAWJrkQ8KqlDs63dxO4nDyY9AY6K9W9mGWy9HQ4rP
         GfvoH0iPzabpaStnnXPl0EAXXhImuMwYxU77r37S1HjfhCzZIxB5jTB1RlbSZzSPUBQ7
         e6SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725466404; x=1726071204;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:reply-to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u+KeQ7XnTBV2WaOnAo0adDENVgOrsRCd5/2OivjahVY=;
        b=Lm4rKC7aVstSMt/KY6kOIrwn437K8+D+7Yhq4o/Ul4svD0E6uBHycEXKeRO34mRsLt
         IVPvaykjdjnhuXrixadeEyqJHJeFIZyDpD3+6VOHthbtuAfnSg8FPIWAGat4DY6aGiG1
         o9j/Q0glE+SVRDuNyk4wcK8XmmYFdVY5ZYRefZN1WEZw0jaxkYDUYUj3yOu5NJVgfnNg
         x1j2Is2hO4KqaVTd7w4GR5uVLjuWH7j9QaDKBBMLI266dq6qY6FghlyK6qRfJUYe/Iwx
         3BmaA65KX/Tnl6N/W1DVpIk7T3+F9dj4HZMlCufCCiQlf1/3Q38nOyDTkdQqNyd3Z250
         60Bg==
X-Forwarded-Encrypted: i=1; AJvYcCUPS6poEdGwrj+6F/J8lPAXXW/6XOPbdYM4qqhaR101TjqskKereTbQW8NVPJCg++O7keIKGyBz5Gw=@vger.kernel.org, AJvYcCWCn0z7KavElldPxis3AM8BfzHez6TcYy1OYHyKjhQ0GF4/auNwJrq81khRty9Erm5KYb32LXLu@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5VdAhLqMMzgvG0SoW0Roi3+hs3e6TeofIt8WoOV+Dk6g/X3ru
	3wbsE0m400/9fWhId0Rwl7o/0dhKKXdfy3xK4ZjmeMWUaC7uE2BZxxDw5Q==
X-Google-Smtp-Source: AGHT+IGV9Ff/qdreHJMX/3XqXAWmM2KInRxmfz1L2SMpd8lFo43zrs/nU9pvyb15M8Cm9Vqp17l1qw==
X-Received: by 2002:adf:b102:0:b0:364:6c08:b9b2 with SMTP id ffacd0b85a97d-3749b57f3d6mr12737370f8f.45.1725466403716;
        Wed, 04 Sep 2024 09:13:23 -0700 (PDT)
Received: from mars.fritz.box ([2a02:8071:7130:82c0:b352:6d7:c693:9659])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374c6543ee3sm10184097f8f.12.2024.09.04.09.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 09:13:22 -0700 (PDT)
Message-ID: <28a20a6697dbe610bd13829baa9d188ef22a1742.camel@googlemail.com>
Subject: Re: [PATCH net-next 16/20] can: rockchip_canfd: prepare to use full
 TX-FIFO depth
From: Christoph Fritz <chf.fritz@googlemail.com>
Reply-To: chf.fritz@googlemail.com
To: Marc Kleine-Budde <mkl@pengutronix.de>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org, 
 kernel@pengutronix.de, Alibek Omarov <a1ba.omarov@gmail.com>, Heiko
 Stuebner <heiko@sntech.de>
Date: Wed, 04 Sep 2024 18:13:21 +0200
In-Reply-To: <20240904094218.1925386-17-mkl@pengutronix.de>
References: <20240904094218.1925386-1-mkl@pengutronix.de>
	 <20240904094218.1925386-17-mkl@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

> The workaround for the chips that are affected by erratum 6, i.e. EFF
> frames may be send as standard frames, is to re-send the EFF frame.
> This means the driver cannot queue the next frame for sending, as long
> ad the EFF frame has not been successfully send out.

just a nitpick, shouldn't it be "as" instead of "ad" ?


