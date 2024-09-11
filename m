Return-Path: <linux-can+bounces-1471-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D70D0974B84
	for <lists+linux-can@lfdr.de>; Wed, 11 Sep 2024 09:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D5141F27D8F
	for <lists+linux-can@lfdr.de>; Wed, 11 Sep 2024 07:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C074A13B580;
	Wed, 11 Sep 2024 07:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D0KVW+R/"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3B013DDC2
	for <linux-can@vger.kernel.org>; Wed, 11 Sep 2024 07:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726040106; cv=none; b=IzLyXh0zhClkZsgsxxtqvS6L0EyIWicdboE0H6kxz6DYm5WIcZayT6SnZxn0xNixRYMnQTEM3ZQgLXJIMcyJEqyipamc8c1GAmf4IWHtlFVFoBwGSjNq13053UX0HDcleuHfr/uz/mUXXiQ5gDWswYtEA2Po8S6/JaarqYDyFnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726040106; c=relaxed/simple;
	bh=kKWQPNvhYypWRS7EeYOhq1mlV3zMx4MDQP0K4tHAeRM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=sQ0Sk0n/C1M2KEIKaYfTDY3SeeWnb5ZjoWCOJ/3ZIVbmAptVVwPOztrM2LJGgyrU0sQYa2ZXESPEerdOw5ya7ICpYbbvusdfszugxH+pDyTr8RLD8BFtxwQuS+tq0DbTT4niH90H+lT6HhGd5q4yGwKqT7T4U6KyK8+bvTG16/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D0KVW+R/; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42cb806623eso14776115e9.2
        for <linux-can@vger.kernel.org>; Wed, 11 Sep 2024 00:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726040103; x=1726644903; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CJH2cy52cLp8quqoKvXlx2SOYGTLdpLWE7Jmva1ASxM=;
        b=D0KVW+R/eO+BRLjVQcFHGjUcRWp1bOyhpfkgU0sjYIP24QyzUcmkMlyvVSe2us4m00
         JbAQ27hH4mBHsBDOX3nQtsoh0ZsLmCiw0bB81R6Nx01BuGZSccrTPwSo6qYlmjk4oeaq
         38CwQZ/HxO6YpHuc/GkXPwCUUaLnUtQRnTcz0wT7hOLUfE91Z2iD6bdbWbaNe77sXxvz
         E4wAUBGoYkQYl9HrG3yvwy+5YjMPWZuPU8UNMNp/bkgQW6wpFMWMcCKGLeXWYOkcJ645
         UEf6qsoRETdqohapwKPMoNgnFk6uEGGXLB7L+Qwn4gaNpQFLGsJ1wbQXsMp39PE3/3eH
         3H8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726040103; x=1726644903;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CJH2cy52cLp8quqoKvXlx2SOYGTLdpLWE7Jmva1ASxM=;
        b=N6QfO/5XEu8ypxavt9ZcxYfxQQYEnYVkJ96bh4qk1C2u0lOA+Y+Ln/x9io+d1qiefR
         1/uE719L3io5D3Lmvghzbh37sqzYF8mdtubVpfboxJCdje5gujHlmr0e9LJe49yRYqio
         JJ3lGuyvL9ezJILJq2+TUizt+9DhRruXgieP6t8YFEx9xrYIa9Brb0VbrqvaJE3NAxZg
         jaIX4eqSCSYSLma9t9VdaN/0nNkUtV1/dy4tWe7h0HwqBEsKWLqiPDcq6YZF9gjlbdEq
         ercYRg8sejBCVDg/m0Pr7zJZcuABnml9G/wiAW1+YqAlQStft5HjnW/Y9SzUC80RZGtQ
         PYXQ==
X-Gm-Message-State: AOJu0YzUY32sILKSkOL/R/mMDbKQfXVJ8KiBG9oqbr3T9PDh+aVup+vC
	Cpgy+oiOZEkQMHXQNmKFOazqWrGnI8149R1rXGiSxQ4NkHA7BA/qCcWxtKv6BTb0jAoshhySwSy
	V
X-Google-Smtp-Source: AGHT+IERRcJIJ+5+0PF6anoIo+2AvOwR8uWpBgXep6pSaA0Fuo40R1YFg80PPwr87qY1w5fiTy9PVg==
X-Received: by 2002:a7b:c412:0:b0:42c:b4f1:f2ad with SMTP id 5b1f17b1804b1-42ccffcfe97mr8508725e9.33.1726040103223;
        Wed, 11 Sep 2024 00:35:03 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956767dasm10912107f8f.62.2024.09.11.00.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 00:35:02 -0700 (PDT)
Date: Wed, 11 Sep 2024 10:34:59 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org
Subject: [bug report] can: rockchip_canfd: add driver for Rockchip CAN-FD
 controller
Message-ID: <9a46d10d-e4e3-40a5-8fb6-f4637959f124@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Marc Kleine-Budde,

Commit ff60bfbaf67f ("can: rockchip_canfd: add driver for Rockchip
CAN-FD controller") from Oct 11, 2023 (linux-next), leads to the
following Smatch static checker warning:

	drivers/net/can/rockchip/rockchip_canfd-core.c:497 rkcanfd_handle_error_int_reg_ec()
	warn: duplicate check 'reg_ec & ((((1))) << (21))' (previous on line 493)

drivers/net/can/rockchip/rockchip_canfd-core.c
    481                 else if (reg_ec & RKCANFD_REG_ERROR_CODE_RX_BUF_INT)
    482                         cf->data[3] = CAN_ERR_PROT_LOC_INTERM;
    483         } else {
    484                 cf->data[2] |= CAN_ERR_PROT_TX;
    485 
    486                 if (reg_ec & RKCANFD_REG_ERROR_CODE_TX_SOF_DLC)
    487                         cf->data[3] = CAN_ERR_PROT_LOC_SOF;
    488                 else if (reg_ec & RKCANFD_REG_ERROR_CODE_TX_DATA)
    489                         cf->data[3] = CAN_ERR_PROT_LOC_DATA;
    490                 /* RKCANFD_REG_ERROR_CODE_TX_STUFF_COUNT */
    491                 else if (reg_ec & RKCANFD_REG_ERROR_CODE_TX_CRC)
    492                         cf->data[3] = CAN_ERR_PROT_LOC_CRC_SEQ;
    493                 else if (reg_ec & RKCANFD_REG_ERROR_CODE_TX_ACK_EOF)
                                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

    494                         cf->data[3] = CAN_ERR_PROT_LOC_ACK;
    495                 else if (reg_ec & RKCANFD_REG_ERROR_CODE_TX_ACK)
    496                         cf->data[3] = CAN_ERR_PROT_LOC_ACK;
--> 497                 else if (reg_ec & RKCANFD_REG_ERROR_CODE_TX_ACK_EOF)
                                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This is an else if statement so this is dead code.

    498                         cf->data[3] = CAN_ERR_PROT_LOC_ACK_DEL;
    499                 /* RKCANFD_REG_ERROR_CODE_TX_ERROR */
    500                 else if (reg_ec & RKCANFD_REG_ERROR_CODE_TX_OVERLOAD)
    501                         cf->data[2] |= CAN_ERR_PROT_OVERLOAD;
    502         }
    503 
    504         switch (reg_ec & RKCANFD_REG_ERROR_CODE_TYPE) {

regards,
dan carpenter

