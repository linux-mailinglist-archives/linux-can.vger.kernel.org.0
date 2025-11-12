Return-Path: <linux-can+bounces-5366-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3823C51977
	for <lists+linux-can@lfdr.de>; Wed, 12 Nov 2025 11:14:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63F9118875EF
	for <lists+linux-can@lfdr.de>; Wed, 12 Nov 2025 10:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227C22FFFA7;
	Wed, 12 Nov 2025 10:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="CUikGddO"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-m3269.qiye.163.com (mail-m3269.qiye.163.com [220.197.32.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFADB2FE579;
	Wed, 12 Nov 2025 10:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762942304; cv=none; b=UVCSUbP7pdmU1XnsREA7Qyg+dc7IO0qzwqMYdc9P37RJF0y06YVRb0hQDq0z0RJ57wHXQ5hwgCKyXGpjgI3GZ4qHt/dEbQUgeZOjELpM9vcE5VTGYI1qekGZ0eWFRApt/H93oq8LgNeG4JfZF8BgpfMjsfhVfha0aN+kMry9APM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762942304; c=relaxed/simple;
	bh=8Zg3/sAelgEsfuI8Ay2dOVaGCjjKJg7Cb8Yt2m9i36A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UHmKZyHpQwaWioePP+4YJTBgTngyPvEkYiYMNJePq0RQeHzAzuLZ2VtoqT0nXhLpsaZLWxFdtgcwVsw+LaoFbZetop0Qp+8NfuSpSFYhVTPuGXqRJ67AuoXID3noMop2ApyNB8YuAev3m83DLeMgkC3djoZLrPIxbAe23G+/KiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=CUikGddO; arc=none smtp.client-ip=220.197.32.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.30] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 295429862;
	Wed, 12 Nov 2025 18:06:27 +0800 (GMT+08:00)
Message-ID: <65ff0185-e471-40ba-8991-43b1a42b1d30@rock-chips.com>
Date: Wed, 12 Nov 2025 18:06:26 +0800
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v8 1/4] dt-bindings: can: rockchip_canfd: add
 rk3576 CAN controller
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: kernel@pengutronix.de, mailhol.vincent@wanadoo.fr, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de, cl@rock-chips.com,
 linux-can@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20251112015940.3695638-1-zhangqing@rock-chips.com>
 <20251112015940.3695638-2-zhangqing@rock-chips.com>
 <20251112-faithful-olive-orangutan-0dd207-mkl@pengutronix.de>
From: zhangqing <zhangqing@rock-chips.com>
In-Reply-To: <20251112-faithful-olive-orangutan-0dd207-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a7787ea7c03a3kunmc052c1ea2aa6e8
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkMYTVZPSRhDT0IeSU0eQktWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=CUikGddO+ZN7whhA7uNkqz4Av3a3h3ecRTM839aDoNwjuOT1rwIvlBvuulvGqith6x6wghvs//J4PEegTy0+yeZjxi8SwbDF5kIi21lFqzQibcnJjjIhx3cu0PbBFOG9OjhGdhUCKwYl/KKZQSOJBth+Om6cVQWjzRsmv01d2KI=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=9n0Y+NoH+kvwHdRXyYxizd4Ni80WNG4fVyyRdV90H6M=;
	h=date:mime-version:subject:message-id:from;


在 2025/11/12 16:53, Marc Kleine-Budde 写道:
> On 12.11.2025 09:59:37, Elaine Zhang wrote:
>> Add documentation for the rockchip rk3576 CAN controller.
>>
>> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
>> ---
>>   .../bindings/net/can/rockchip,rk3568v2-canfd.yaml  | 14 ++++++++++----
>>   1 file changed, 10 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/net/can/rockchip,rk3568v2-canfd.yaml b/Documentation/devicetree/bindings/net/can/rockchip,rk3568v2-canfd.yaml
>> index a077c0330013..22e10494e7d1 100644
>> --- a/Documentation/devicetree/bindings/net/can/rockchip,rk3568v2-canfd.yaml
>> +++ b/Documentation/devicetree/bindings/net/can/rockchip,rk3568v2-canfd.yaml
>> @@ -10,13 +10,12 @@ title:
>>   maintainers:
>>     - Marc Kleine-Budde <mkl@pengutronix.de>
>>
>> -allOf:
>> -  - $ref: can-controller.yaml#
>> -
> What happened to the allOf?
This is a misoperation and will be corrected in version V9.
To speed up the review of the current version, V9 will also remove dma.
>
>>   properties:
>>     compatible:
>>       oneOf:
>> -      - const: rockchip,rk3568v2-canfd
>> +      - enum:
>> +          - rockchip,rk3568v2-canfd
>> +          - rockchip,rk3576-can
>>         - items:
>>             - const: rockchip,rk3568v3-canfd
>>             - const: rockchip,rk3568v2-canfd
>> @@ -43,6 +42,13 @@ properties:
>>         - const: core
>>         - const: apb
>>
>> +  dmas:
>> +    maxItems: 1
>> +
>> +  dma-names:
>> +    items:
>> +      - const: rx
>> +
>>   required:
>>     - compatible
>>     - reg
> regards,
> Marc
>
-- 
张晴
瑞芯微电子股份有限公司
Rockchip Electronics Co.,Ltd
地址：福建省福州市铜盘路软件大道89号软件园A区21号楼
Add:No.21 Building, A District, No.89 Software Boulevard Fuzhou, Fujian 350003, P.R.China
Tel:+86-0591-83991906-8601
邮编：350003
E-mail:elaine.zhang@rock-chips.com
****************************************************************************
保密提示：本邮件及其附件含有机密信息，仅发送给本邮件所指特定收件人。若非该特定收件人，请勿复制、使用或披露本邮件的任何内容。若误收本邮件，请从系统中永久性删除本邮件及所有附件，并以回复邮件或其他方式即刻告知发件人。福州瑞芯微电子有限公司拥有本邮件信息的著作权及解释权，禁止任何未经授权许可的侵权行为。

IMPORTANT NOTICE: This email is from Fuzhou Rockchip Electronics Co., Ltd .The contents of this email and any attachments may contain information that is privileged, confidential and/or exempt from disclosure under applicable law and relevant NDA. If you are not the intended recipient, you are hereby notified that any disclosure, copying, distribution, or use of the information is STRICTLY PROHIBITED. Please immediately contact the sender as soon as possible and destroy the material in its entirety in any format. Thank you.

****************************************************************************


