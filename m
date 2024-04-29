Return-Path: <linux-can+bounces-507-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F28CB8B61D7
	for <lists+linux-can@lfdr.de>; Mon, 29 Apr 2024 21:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD4772822ED
	for <lists+linux-can@lfdr.de>; Mon, 29 Apr 2024 19:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6199513AA48;
	Mon, 29 Apr 2024 19:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j9lsIxCT"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C372212B73
	for <linux-can@vger.kernel.org>; Mon, 29 Apr 2024 19:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714418328; cv=none; b=DMCLCDx70EH9Jllo3P2Vq+yqAtGfUdwQTefjfCyZRovzi14YkNJ6TXdVCMwvmznkbpsVmIBmn89XqrKwofB2JomDhQgXUGbd0Y+G8hN/Sg4pDH7CSwgh7nBrkBFmXzI+lzKGjVFS9HTnkhtFVFHCY9O+SiHzQUyO6S+t/mViYZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714418328; c=relaxed/simple;
	bh=ZNTz1i+5HzdFLNP/I1STBxLen6l+wTF3Nz1pHKLW1aQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zuqs/eEdtQg4U9qzWWZnhs9H2iP04KQvTT/WB2QiUDB/Ff+kw6hEULz0EBTlKiuhSfncELwKirIdco8uOQHmsvlDTwGN8fZ8oc+sNMzPBzwuT5ztownwKCdgkA35571AXbgnJKAEEmH2XQMHSvMj/m8CpoY/f4AA9JNzeBLAC34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j9lsIxCT; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-518a56cdbcfso7688014e87.2
        for <linux-can@vger.kernel.org>; Mon, 29 Apr 2024 12:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714418325; x=1715023125; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G3l9wwUs8KwYEkfZ49GfWDPuR+3lqBh98x9WfwgCI+A=;
        b=j9lsIxCTZ8Cq8/VTPcUwK0lemy3rrawZNkWXBBS71/dQvG15J/jB9/EFbdq0ufuEJ+
         lFDJqGyIFT5vRj5ecmdbi9kvCITnU68MxXOHf7DGdnxVTeSb45pK5BC4yaUHlXxY6sMa
         CJbJZWiQRbDP5CEc+7VAP0Mrs2bm9PUbV6nijAZ73ApKV8gEkCMLD/7A0HSCm9/g8SWX
         P5TzsFefemMdPaDTp5FzotjoFd2/g717QsWEccC2Dq2hd/dwOS0KC4HLzaryAVjb4e90
         46sg5Tk0THXIZ1qb7xvakZlJoMsgOfC3s9PcZl9Pk6oynfIRWbiXKe1ouruRjc9/qZ9t
         Gzlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714418325; x=1715023125;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G3l9wwUs8KwYEkfZ49GfWDPuR+3lqBh98x9WfwgCI+A=;
        b=SNZvMQ3I3OuasFtWPm/QQqrf9R2iHyIyraVsRozy175C4urICbibqOcaounvpIQZ9y
         7lFvXymVozxDEhnJ8cy38iybTxhvSKK3HBS+kcwLI2BBIAlfty5L2DxcXCy9E9QhxCFr
         ESSwOib45z3FMQRzznq+UlL2DPQMlu/lxyhHsESs+HWVZTEVMRphP05F37EKXps3EGYc
         DbWBhxxK6ypWtf6DyZAhlwE70x0HRnzSex+o6VN5X/X4MFKosCpxmrNIBudoIOunoqyG
         cRKQWdqqqps+wKy3673yupppMTw1+93OymDxtRxtoM5wwSmPUL7t1mNN6fevYNEKtGIB
         B80w==
X-Forwarded-Encrypted: i=1; AJvYcCXiTmSYhpZqjC39QN6eNgJN4tNXCa386rArdDXiTb+/43oXT+rDoTqdN3NCbD6BlfwEqMUfoXjjIokZqH8PqjON0huBpeX9epNI
X-Gm-Message-State: AOJu0YwvV9MxAxbNuSvMicb5T3nL55cD36YSgKL+N7ywyevUSnbIYNi6
	mRH5WkEbfqcvi5zUCi3+lbL/j00iOQBwTUM4KmIDzGrpwY0F8d83
X-Google-Smtp-Source: AGHT+IEC058YEbp+pVLUfAwrH7yK7aTh5lGTE7/Fd1MGUG2j6TEglCmYNeSXAwxnA3jiW/bA0nZSZw==
X-Received: by 2002:a05:6512:6c9:b0:51d:9291:6945 with SMTP id u9-20020a05651206c900b0051d92916945mr5031287lff.44.1714418324421;
        Mon, 29 Apr 2024 12:18:44 -0700 (PDT)
Received: from fedora (host-95-248-171-25.retail.telecomitalia.it. [95.248.171.25])
        by smtp.gmail.com with ESMTPSA id r20-20020a170906705400b00a555ef55ab5sm14182370ejj.218.2024.04.29.12.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 12:18:44 -0700 (PDT)
Date: Mon, 29 Apr 2024 21:18:42 +0200
From: Francesco Valla <valla.francesco@gmail.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Subject: Re: [PATCH v3 0/1] Documentation: networking: document ISO 15765-2
Message-ID: <Zi_ycjkN9b95Rsx9@fedora>
References: <20240426151825.80120-1-valla.francesco@gmail.com>
 <20240429-mighty-starfish-of-speed-c76ddf-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429-mighty-starfish-of-speed-c76ddf-mkl@pengutronix.de>

On Mon, Apr 29, 2024 at 07:31:10PM +0200, Marc Kleine-Budde wrote:
> On 26.04.2024 17:18:12, Francesco Valla wrote:
> > While the in-kernel ISO 15765-2 (ISO-TP) stack is fully functional and
> > easy to use, no documentation exists for it.
> > 
> > This patch adds such documentation, containing the very basics of the
> > protocol, the APIs and a basic example.
> 
> Applied to linux-can-next.
> 
> Thanks,
> Marc
> 

Hello Marc,

Is there still time for a v4? I have a couple of typos to be fixed plus
an additional Reviewed-by. See:

https://lore.kernel.org/linux-can/CAMZ6RqJ8x1=SeZRyR8PBCHzOy7qjB4xPs2Uk4mHLHOm_Usy91A@mail.gmail.com/

Thank you

Regards,
Francesco


