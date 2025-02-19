Return-Path: <linux-can+bounces-2852-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0052EA3BBA5
	for <lists+linux-can@lfdr.de>; Wed, 19 Feb 2025 11:29:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E8337A4490
	for <lists+linux-can@lfdr.de>; Wed, 19 Feb 2025 10:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DDD31D79B6;
	Wed, 19 Feb 2025 10:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZIgGHQS"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB6E155753;
	Wed, 19 Feb 2025 10:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739960942; cv=none; b=UtKhYvuybE+M19CCR/SP46qdFpecw6JQJsKU1t/Q3krj3F2zgN3OPSnTfgH/8pcbKxvmqu+EEephQq6RmFh+ScXj4Tt6OUGXrGOn6OpQQ/rGygn+yyWWhAsMTOOCWLCVrXjAQCejIp/xZ8RruCWru2krOlmDPSV8zetSljUO/Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739960942; c=relaxed/simple;
	bh=dTy7kgJLz8uEW2tF3dDC1mdS9gH2aS8cAJdE5jPiMp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WO46yrHY85UtKjH/smDRIRvcygCTBcT2YfdWESVFYiK3LtmVdlup1DIWC9bcYqL/tO5V4zvEaQU8xd+lPk5CBxdYl4ZvHmpI/kzT4uS0Z4aPNChW+bjAZPmGD32dj4xI6PE6eKKNbEgEC1IQxbbnqYZs7FOdLuVPGoL+/CzCqFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RZIgGHQS; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aaf900cc7fbso989173266b.3;
        Wed, 19 Feb 2025 02:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739960939; x=1740565739; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LsEKril/EX6NGOi9AuHscz8JJQEqiJ3caiBRAkVCLUs=;
        b=RZIgGHQSJPjAOeVJxwfgC75hDnLWGtNYzVYXMBZC7Mj6agoxkl9f6feQRyKbrkRNn0
         lqKCfJJITJ+3sL5UDv5R424soaT097yi2Eb0SMH4GEKFNXk6O6NQM++ICpNyZwYcj1PX
         Mw4m3Crfb1SANb14HEcOzpXPEd7W8lrNgHCfM7KKyASUv3lIaxEm/zEm97rerdwg1xeH
         4Xc7QI+fslTennphYyu58NuotM8+TCvjpQtbyNe4xWTjssQ9geFYMCgPbSDVboMd9aG/
         V9pNel9a5ZLI5tNdqRHHSKpXc9uoHGDV7IkzLZ0hCEfGdLVU0ekacL/mD3cT8HmwTMqt
         0vwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739960939; x=1740565739;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LsEKril/EX6NGOi9AuHscz8JJQEqiJ3caiBRAkVCLUs=;
        b=LhqkZLI9uPoF9UWqVsaxP6iQMRhmLdu41DygIOyRsDz8FZkJRJsSjjvKYrVEV6CEe9
         ypcs5zRJs8o47NOWEY5hrl8GPLs6c/qSQUUHCeaHPSJwK3hwn04VMKpSZifplcXEVvzd
         Pe2+kOMZPz0bDgqKtmSO7+66Xpml8NpZHLm5N54DgT9rNbwvEw67bJtp8xvZScsyIKFD
         xWuOvPNKaKgRR4pUd4LZP+xANDB0QZcqY7q9Rxmci2IsdOWcpgUlw81ZlxWcVUrdx+sX
         x0N6U3/NMnztlXx9VOPgqVuR+r4fw1VNjCphtcfQrLGfB2ifmuC0HILjO8L4Rd+nCtD9
         1P+w==
X-Forwarded-Encrypted: i=1; AJvYcCUN6mUfBwsLay2oddV/Bl7XxM2fEhY5KCXLvVZP8muuysoOzoiKwPtThgNB5hSqnOTEOSv1rt74kTnJ@vger.kernel.org, AJvYcCUls//PDieIj82z51j8m8tjC0963bDjj7j1y+TbaK00liGd4KLzQSyP+zpu2aoAIkOFmd3G4o4ADjo9/rL3@vger.kernel.org, AJvYcCWmFNhuAnyXJoud7aDZPwYIfwRcgQcdxnKwxsURqdk7/Myy9Rhmz1iJUCKxz4t+ewnbE8GHs0B/GDr3@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4KDNzlS65HLFaGAcT40YkMcHZhUW9c86BUkk6dSl4nJDL5rCw
	9mN0BIzVSbIHDDDbM7n5Y0aiUO9ZLldnQTD/Fs5VLYO3QuXhCd7mTA2POQ==
X-Gm-Gg: ASbGncv/+kbCQznUFhRBHTqHsQkQ15cce0k4P3lpuyPY7RmBnjHBToU/LTJfFYrlcG9
	h+SUt7d7YpbhSClqY8y9urdhY2mw39yHf/6LbA0jJO2TeaEdw6qY8hM9lZEBeMJ5/O/7TfnQkHu
	FIbNwzn/yMNvIRZseI8H2qovaO/NSxDSD9a6SQEgDEFQ0m3pWOhAp8k+RTEUw/mYyfl6xpvsiA0
	c784fNr0WLfQoCZSbV6mseKVn6nHLplNAcLbDCue/SukE7xLLbHSa8kaeUtfgwSzrLpWdwq2w9k
	XLT93CYt5MtW
X-Google-Smtp-Source: AGHT+IERCwsrYngeQYiwia2oay4tPlR4ratg5zYgI6wHKY5o0gLlObZP3WA2uLSBNxJEm/1Q1/jRng==
X-Received: by 2002:a17:907:d27:b0:aba:5f40:7f2e with SMTP id a640c23a62f3a-abb70d95048mr1686384966b.45.1739960938565;
        Wed, 19 Feb 2025 02:28:58 -0800 (PST)
Received: from debian ([2a00:79c0:646:8200:45fb:7d1a:5e4d:9727])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb9553fbd0sm611778066b.84.2025.02.19.02.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 02:28:57 -0800 (PST)
Date: Wed, 19 Feb 2025 11:28:55 +0100
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Subject: Re: [PATCH 1/2] dt-bindings: can: fsl,flexcan: add transceiver
 capabilities
Message-ID: <20250219102855.GA3888@debian>
References: <20250211-flexcan-add-transceiver-caps-v1-0-c6abb7817b0f@liebherr.com>
 <20250211-flexcan-add-transceiver-caps-v1-1-c6abb7817b0f@liebherr.com>
 <20250219-huge-zippy-hawk-231ae0-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219-huge-zippy-hawk-231ae0-mkl@pengutronix.de>

Hi Marc,

thanks for reviewing. I think I messed up with the previous answer using
my corporate mail account. Sorry.

Am Wed, Feb 19, 2025 at 10:15:11AM +0100 schrieb Marc Kleine-Budde:
> Hey Dimitri,
> 
> thanks for your contribution!
> 
> On 11.02.2025 14:12:33, Dimitri Fedrau via B4 Relay wrote:
> > From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> > 
> > Currently the flexcan driver does not support adding PHYs.
> 
> That's not 100% correct. The flexcan driver does support PHYs, but via
> the old can-transceiver binding.
> 
> Can you rephrase the commit message.

You are right, will fix it in V2

Best regards,
Dimitri Fedrau

