Return-Path: <linux-can+bounces-4148-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C413B11EEE
	for <lists+linux-can@lfdr.de>; Fri, 25 Jul 2025 14:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B967A5A4EA1
	for <lists+linux-can@lfdr.de>; Fri, 25 Jul 2025 12:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B172ECD07;
	Fri, 25 Jul 2025 12:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ou6TODdl"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D598B2ECD0C;
	Fri, 25 Jul 2025 12:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753447505; cv=none; b=kg5blvmyMlkZxS4P98ZMnNkEsFi2Zqkpjph297qFQeG3evfW1g9/hwo0WV2gmhY/NF7ayF9g31Uf6/9EW0EPmhbJle6aE+ZWYUbpthtMT2puGAt1pt+tQ2SKIKzmYBrEVGZ6P4dd385yBCT3wbNv3HAMIrNb1wYCCiQxG+b7CeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753447505; c=relaxed/simple;
	bh=Ivx+3DpkDEVIWgDPE886sL3hmaIO7VVHI5szFYAJzWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eeKK49heqvVkTc8GM+ZT6/s8f4Q0kBml5LxF32okC8VnG1oc6or/wWUDHcyYPUxFKqkf0EqoTxBW7jjsKnTxeZrlt0YmWIOP87dtXguy7LrXpMG0MgFlomQW1XWvjftComCp+Szvf5yHe7OhqSPM9j5wJJWgXzGEfGl3vY5sik4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ou6TODdl; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-558f7472d64so2974968e87.0;
        Fri, 25 Jul 2025 05:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753447502; x=1754052302; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R6TxXc2OJoQQEZeRy0qh5s7Sa5mHuBfc4zIBb0BU55c=;
        b=Ou6TODdlhtIoYBuWZlheh+UgbR2Hh3ReyAvIPhtdCCPJukFwgvnvB6kZ1JnSJ9PgSp
         LgVxokRbCrDVYhC9290jPEIc9rk1GbRIGWhbcXzlPbHOSnLXAgdPE/mmwQ1LQuj0xm//
         4jByisrIf48LrRwme2+6XMWeLirCsqF1h4Mbx5x4WGUkwMp0++7Ty8GXSvosixvRhyQG
         f5gaTnqy9neKtI6nY5O+QdbpOX9pBxrImoJz/fL6OwXB21ckqclGXTIIB8EY/EttdO8d
         8adwFn5KSxj/1mUbJNu9ef9PjK3vUUILpXGsdhIplmbOgSvTJfq81JPxkPs453+Rv/7P
         Dkwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753447502; x=1754052302;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R6TxXc2OJoQQEZeRy0qh5s7Sa5mHuBfc4zIBb0BU55c=;
        b=Sq6gSZvN1eMbdBc6evX0j1123hX+gkopG+FsIDLkGeenA9s0TlcWpW3641o+RbX/7j
         BqJb0gWCfYlJSPEHXDpiAtfh0k2c/w5PDKoXP5+RcOZHadTfoCnvhX2uX+NYVVLPWU5g
         4K5zywGqX+dQTMhJ2c0LD1qY7vwotormpJCXiRbG5cKafJASl4J4iu5kYD924QD67uwU
         2pcfDgMclxqJhifii7veqe88Obmf5Qy65Oet1DW+W0aTk0kcmvNJyYzrsTTfPVWuAJmK
         IAZIVeKIxYmaMHhBm51BfEQGb6ieixE6z4jS3dRxVVeW8e2lPeiMOi15fA/SGnZHGc43
         pBvw==
X-Forwarded-Encrypted: i=1; AJvYcCUNUTQ/v0ucwEbksjoRszKxvz4nK4T80+HjttpAfigFVqCUtIBI6es9O7UoISCbPE5U8Z4waCuqTus=@vger.kernel.org, AJvYcCXMUdT4gWb9N5Ho+v/KZuov5KIHBuqUlLeQK2tVuLWiW4gSV4UJtB8tA7LqENtjWICEmGSfY+MQ@vger.kernel.org
X-Gm-Message-State: AOJu0YyxBENAh7WKOdiO4dr6KdM4SPjSKH3SL7lEAWphGWV/TTkyL103
	OUz3CclkPeApi3mO0HmlHkKNicAVzkhUofKW01s+1qznPNRNb2hd309fdktrEQ==
X-Gm-Gg: ASbGncuz9eYPA5pQ+XyENkea+/tZkMRiPCCHwZETMDhbpLth4qchB1Z4T/j79c4HVze
	H7CngM2ukRtouXEDj/s0pGfXYIpf0Fz2qc9HOPW5+BlESpd1/7GakSk7gL5AONq1F0VWmn5KrTr
	k8y91fugHSNiJX17RWTCQi/tLIvwws1cssRLsbOTXHy0w/FrqCAFn7/1OWB6eKbCF7FV7cKpQt0
	mJhK67vRwBlfAt43RUd6x79ABvmVqz9gfXOjCpkarRLQQG5jo+tl/zeAez4oQsXA+USGIVVzau7
	1IrW98uyR6TiQKumxu8j0vNJ6VzwseVLueHwoZwjyuF/dW60iSIfYV/pMHz+V2m+dR7elMPX2Nd
	q3kbpa7TUfdr7F6wNywdlftzkAvjtNhoFCbB8MU8bTbxIbn0tsS4F9IWp8Y9ZZ4vgOA+SjT8Th6
	iOtSU5pe9LI1g=
X-Google-Smtp-Source: AGHT+IEybm6khkrXEWXr/3/TGkrlr2zgjTyZeiBtLvPmwfN38fI6k5rWT1d0IbR+P/SqIgokzw5w5w==
X-Received: by 2002:a05:6512:1396:b0:55a:32ef:6bc2 with SMTP id 2adb3069b0e04-55b5e53d80emr624196e87.25.1753447501725;
        Fri, 25 Jul 2025 05:45:01 -0700 (PDT)
Received: from [192.168.66.199] (h-98-128-173-232.A785.priv.bahnhof.se. [98.128.173.232])
        by smtp.googlemail.com with ESMTPSA id 2adb3069b0e04-55b53b2288csm921792e87.23.2025.07.25.05.45.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jul 2025 05:45:01 -0700 (PDT)
Message-ID: <94e5ddd2-3566-496d-a4c9-40f72e649811@gmail.com>
Date: Fri, 25 Jul 2025 14:45:00 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/11] can: kvaser_usb: Simplify identification of
 physical CAN interfaces
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
 Jimmy Assarsson <extja@kvaser.com>, linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, netdev@vger.kernel.org
References: <20250724092505.8-1-extja@kvaser.com>
 <aa90e02d-25d5-4f76-bd91-26795825c8a6@wanadoo.fr>
Content-Language: en-US
From: Jimmy Assarsson <jimmyassarsson@gmail.com>
In-Reply-To: <aa90e02d-25d5-4f76-bd91-26795825c8a6@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/25/25 5:29 AM, Vincent Mailhol wrote:
> On 24/07/2025 at 18:24, Jimmy Assarsson wrote:
>> This patch series simplifies the process of identifying which network
>> interface (can0..canX) corresponds to which physical CAN channel on
>> Kvaser USB based CAN interfaces.
> 
> 
> Same as for the kvaser_pciefd, there is a tiny transient issue on a missing
> header include. The rest is OK, so, for the full series:
> 
> Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> 
> 
> Yours sincerely,
> Vincent Mailhol

Think all issues should be resolved.
Thanks for reviewing!

Best regards,
jimmy

