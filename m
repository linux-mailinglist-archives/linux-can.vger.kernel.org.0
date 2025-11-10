Return-Path: <linux-can+bounces-5328-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7886BC45D0A
	for <lists+linux-can@lfdr.de>; Mon, 10 Nov 2025 11:08:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 237161883BF0
	for <lists+linux-can@lfdr.de>; Mon, 10 Nov 2025 10:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04FB530216A;
	Mon, 10 Nov 2025 10:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="F3IgI36c";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BeHTpw9H"
X-Original-To: linux-can@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1AE2EB847
	for <linux-can@vger.kernel.org>; Mon, 10 Nov 2025 10:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762769313; cv=none; b=DDT8DWGnh1a9HWkHkGP5YG0SfY1lb1pzvGGtJbLFXnYKSwOpbmuVWwQpSWCUIuj/siPepg8Azy0GOZIB1E3pPK0/aLhaC+Ym9i5OZFTK3AwtA+xt+iYPOIXlAu/C05i6Tsyg6mgTPmKgFCwYQu0f8fLOenEQEZ+WclCYY9a1ajw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762769313; c=relaxed/simple;
	bh=0dbOoM1JgFEw8FONGDy+H2SN6rDl1TPboIDJvPZ2RZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=on1EdfMGBy6kKs75hmBPMGaJ9FciUfoBJ+4aISjCjnlRgLjwybBH7rlITskI0pPvBxyMEmu5IQxdZuQiF/Ise6iEbklWotbllql8sldFybdcABz70Syo1q29Z76av4G8WEuaCL/UZgfr5gSgopt5WutE4HxF65/mkXpt2HKbVu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=F3IgI36c; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BeHTpw9H; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AA8qLuL1795143
	for <linux-can@vger.kernel.org>; Mon, 10 Nov 2025 10:08:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	z3KAbPP/h+63EoRNBS2Ni6wBbFMkQ1zOPX3P54o6wtg=; b=F3IgI36cgE4ZJveP
	6RqM7bB3ScGFaZBzdgUpY7E9W4zUIIAOHAJkL39s1F6BaecBQvwQQEhZVCtRsxyn
	U98hIFKeNaEFCxcpuSJi/5GIeWh2XSH8YOPr6dI9/56/A58hOjs8e87ReC0JJUTB
	D08ieNxQ4mXOerb+pbcK8Xlom8/gBpunMeeCjQdiLHKuSrC8u6vkoqN9dMi3TRNn
	SP7v9535gIbMp1q+4qvV47Wo8GYUtr7EDPncBqQyDloJIo+9xOfYJBsxj5SuIAjM
	0BmEurNNYL69GKw4FFmsY93gsJU/lOklJejP0oji6fqlwJdsDA0yaDvy3YV4K/kZ
	oNFqPQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a9xvjcagv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-can@vger.kernel.org>; Mon, 10 Nov 2025 10:08:30 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-298389232c4so1400765ad.2
        for <linux-can@vger.kernel.org>; Mon, 10 Nov 2025 02:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762769310; x=1763374110; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z3KAbPP/h+63EoRNBS2Ni6wBbFMkQ1zOPX3P54o6wtg=;
        b=BeHTpw9HgXOl1iWo2PzWMRmPdZ/MIfx78AllhM+/Pg48ukksMAFsZKVFaHns0A77Uc
         Ro6TCEGoRiR6HBXaICHUICVxrOUgBKQiFk1dsipNaX4f4CVX5/gK6xnAV6U3LEFFEgp/
         wPEg45CBQTVx6zDLgN4AqIk0mBgkZRUX0NfaYJtv6O+3xCu31+uYKIuAHtMgfEuf0Zhb
         zuxeLWBf8JmOrd8BDlk1e6actpZ+pjIN4bwo7DUli0OVqUZRasDL/6Ax+O02jO6EDwwH
         wP67Ed0N29/HepJxPKxfIMl7jcRR9y+g+Ndmnf3xbHK+ZfqWeQpY56QqkltfjGZHlPY4
         qPIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762769310; x=1763374110;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z3KAbPP/h+63EoRNBS2Ni6wBbFMkQ1zOPX3P54o6wtg=;
        b=WnUkZSkr/XQ4Y4OWcc833e7GVeDzTQkyzVwoDqTO+/Ws2fqpYhtkE4rB5z/TUJQtQA
         Ja9l+TsfMtb3hvMBcudq3d4khaXW3vWkIPTbS6csy7nIAFZiLA5kyKcyRb2jTI7vkPFr
         PcwYy8GVSsM683wluv73aIYaijhDX3cGkGDI5d9P8Ea8nm6xGj2a3bzYPEwRrjwr0C47
         qvB5kRC2UC8PrmlHKdxN04RyVjfmocQSIHgsasj0YjbWCx5M2F5cciC/tAZuCCxRjh4A
         J6X6XzC0SiEIxFZ0iMAIwR+A4IskcX/Nv9eG1Z7/QKUEL1Wrc0tfNl/LV04QBCVenZ5x
         oRoA==
X-Forwarded-Encrypted: i=1; AJvYcCX1ILgJVZJ9kvpaTOMkf3+ikWjQNeB2MuqNpiCxhNJ/nIUVUasC8jAK6382knf5G4EvLlKRB7fwmO0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi/gGVathOTzuZROz1701CLFwWJ0N1M7Z7q+eDJy/RQwb+Yp1z
	LOg94aSH6GUC3Yt9tupUrxxiPxopez1sotHnRJEUBA+basHvgHWD5d8wAtrGVJTXcneDtuJb0Q9
	+qugq9pAgJ5u081ybRkJDi0RZeDuyYZ64KTs8ZlWT4UtAKeVq0JVVenArbFVSXt4=
X-Gm-Gg: ASbGncsHqrR+EDgBZ0MvhMNUOunvhI0gRvemPibeagoo3TelyrD982AhLm+BhzJGvaO
	w6STReI7VbWB6JAljPR6p5Up8heHf4NFcVtG4W5JhJ0upeURVUMkeaykhqbreeMqCqOpX0oL0U3
	cnDWrcHxY9CVi3En0nKrIqfXwQJvAZ89F7pcGMVtlz3Cft5NU4lNBU+GpEV6Eow9zQHYbb4o9ce
	z/aQoTJJqhPUvicBMdAmoLEAP6fFj8UESFj56h54NZ0Rw9rZexKGCPWqvMbVk+NSBih8ijJ820M
	DqzqqrHTFkRlj03p1DbTnUWz0oGp+yIYXtbru4Vwl/EWUCZ5FqtD6ZOyipyH1Dh9mcrEj75I9dD
	RVFUk3HO4ndJc+W5Ic28LpiHORK7L9+A=
X-Received: by 2002:a17:903:40c9:b0:297:d741:d28a with SMTP id d9443c01a7336-297e56c9eb4mr84302475ad.31.1762769309734;
        Mon, 10 Nov 2025 02:08:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHyXqPJFzXxIoU0geQ41zcRiNCHrftpqqkDVpgzXcbP6SifdSRX3i0G9WOKxg+fHf1fYfI9Hw==
X-Received: by 2002:a17:903:40c9:b0:297:d741:d28a with SMTP id d9443c01a7336-297e56c9eb4mr84302105ad.31.1762769309152;
        Mon, 10 Nov 2025 02:08:29 -0800 (PST)
Received: from [10.218.4.221] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c93cebsm140244045ad.90.2025.11.10.02.08.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 02:08:28 -0800 (PST)
Message-ID: <8776d2ca-90b9-7e14-a278-01f20e81297a@oss.qualcomm.com>
Date: Mon, 10 Nov 2025 15:38:22 +0530
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v6 0/6] can: mcp251xfd: add gpio functionality
To: Manivannan Sadhasivam <mani@kernel.org>, mkl@pengutronix.de
Cc: thomas.kopp@microchip.com, mailhol.vincent@wanadoo.fr, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, linus.walleij@linaro.org,
        brgl@bgdev.pl, linux-can@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mukesh.savaliya@oss.qualcomm.com,
        anup.kulkarni@oss.qualcomm.com
References: <20251001091006.4003841-1-viken.dadhaniya@oss.qualcomm.com>
 <dvqn5hwvoi36djxkfte2sw2o2nnk7irh6tgt5vmtqgm6t2dbyc@snde7uwlzbia>
Content-Language: en-US
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
In-Reply-To: <dvqn5hwvoi36djxkfte2sw2o2nnk7irh6tgt5vmtqgm6t2dbyc@snde7uwlzbia>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=QuxTHFyd c=1 sm=1 tr=0 ts=6911b99e cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=8f9FM25-AAAA:8
 a=JNVGp1IlC4mDD8BcjtkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=uSNRK0Bqq4PXrUp6LDpb:22
X-Proofpoint-ORIG-GUID: ZAOddxJP6wwTTE7A16Exa5fq7vfTy-_e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDA4OCBTYWx0ZWRfX0AXSzBETALem
 jRDXFHnAel5eLFgG6cgUX11Mn9rYiSfQK5gZfL32ZgkeWA3xV1rghbSppSj4R7GtnMTCuhWFZ9g
 sbOixRvgn1XJ69E4685Mp9HDOgUX74eh+WhOWTsbj4pJCcpWzCjiuI4Upxhs+NLiRcCJWUs6hxd
 xiCCKf2LdZOeVl2Fy8mJqxbg3GGER7vrR0Wf50s+1yBmgijx1KdgvquuecBknm7LqJQE3sczTLu
 stz8mCP+KeZsJmA0RwG/vKlOEVplUhE8ABc/Pxrvvono+q13ccqQKI05/7QOGzLV4CgQMd1CtU4
 w/VCA5iczxmK1BCTbq+thLR9l9du8igE4uBof7KyCInrUirVrURhXrghS7N1jitovBN2FEvsKo1
 nvg8WorwCNl14Pl3qt3ohs4k1mrA6g==
X-Proofpoint-GUID: ZAOddxJP6wwTTE7A16Exa5fq7vfTy-_e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_04,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0
 spamscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511100088

Hi Marc

I wanted to follow up on this patch series. I noticed it hasn’t been picked up yet,
so I wanted to check if there are any remaining concerns or comments that need to be addressed.

Thanks
Viken Dadhaniya

On 10/23/2025 10:46 AM, Manivannan Sadhasivam wrote:
> On Wed, Oct 01, 2025 at 02:40:00PM +0530, Viken Dadhaniya wrote:
>> Hi all,
>>
>> The mcp251xfd allows two pins to be configured as GPIOs. This series
>> adds support for this feature.
>>
>> The GPIO functionality is controlled with the IOCON register which has
>> an erratum.
>>
>> Patch 1 from https://lore.kernel.org/linux-can/20240429-mcp251xfd-runtime_pm-v1-3-c26a93a66544@pengutronix.de/
>> Patch 2 refactor of no-crc functions to prepare workaround for non-crc writes
>> Patch 3 is the fix/workaround for the aforementioned erratum
>> Patch 4 only configure pin1 for rx-int
>> Patch 5 adds the gpio support
>> Patch 6 updates dt-binding
>>
>> As per Marc's comment on below patch, we aim to get this series into
>> linux-next since the functionality is essential for CAN on the RB3 Gen2
>> board. As progress has stalled, Take this series forward with minor code
>> adjustments. Include a Tested-by tag to reflect validation performed on the
>> target hardware.
>>
> 
> LGTM! For the series,
> 
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> 
> - Mani> 
>> https://lore.kernel.org/all/20240806-industrious-augmented-crane-44239a-mkl@pengutronix.de/
>> ---
>> Changes in v6:
>> - Simplified error handling by directly returning regmap_update_bits() result.
>> - Added Acked-By tag.
>> - Link to v5: https://lore.kernel.org/all/20250926133018.3071446-1-viken.dadhaniya@oss.qualcomm.com/
>>
>> Changes in v5:
>> - Removed #ifdef GPIOLIB and added select GPIOLIB in Kconfig
>> - Rebased patch on latest baseline
>> - Resolved Kernel Test Robot warnings
>> - Link to v4: https://lore.kernel.org/all/20250918064903.241372-1-viken.dadhaniya@oss.qualcomm.com/
>>
>> Changes in v4:
>> - Moved GPIO register initialization into mcp251xfd_register after enabling
>>   runtime PM to avoid GPIO request failures when using the gpio-hog
>>   property to set default GPIO state.
>> - Added Tested-by and Signed-off-by tags.
>> - Dropped the 1st and 2nd patches from the v3 series as they have already been merged.
>> - Link to v3: https://lore.kernel.org/linux-can/20240522-mcp251xfd-gpio-feature-v3-0-8829970269c5@ew.tq-group.com/
>>
>> Changes in v3:
>> - Implement workaround for non-crc writes
>> - Configure only Pin1 for rx-int feature
>> - moved errata check to .gather_write callback function
>> - Added MCP251XFD_REG_IOCON_*() macros
>> - Added Marcs suggestions
>> - Collect Krzysztofs Acked-By
>> - Link to v2: https://lore.kernel.org/r/20240506-mcp251xfd-gpio-feature-v2-0-615b16fa8789@ew.tq-group.com
>>
>> ---
>> Gregor Herburger (5):
>>   can: mcp251xfd: utilize gather_write function for all non-CRC writes
>>   can: mcp251xfd: add workaround for errata 5
>>   can: mcp251xfd: only configure PIN1 when rx_int is set
>>   can: mcp251xfd: add gpio functionality
>>   dt-bindings: can: mcp251xfd: add gpio-controller property
>>
>> Marc Kleine-Budde (1):
>>   can: mcp251xfd: move chip sleep mode into runtime pm
>>
>>  .../bindings/net/can/microchip,mcp251xfd.yaml |   5 +
>>  drivers/net/can/spi/mcp251xfd/Kconfig         |   1 +
>>  .../net/can/spi/mcp251xfd/mcp251xfd-core.c    | 273 +++++++++++++++---
>>  .../net/can/spi/mcp251xfd/mcp251xfd-regmap.c  | 114 ++++++--
>>  drivers/net/can/spi/mcp251xfd/mcp251xfd.h     |   8 +
>>  5 files changed, 335 insertions(+), 66 deletions(-)
>>
>> -- 
>> 2.34.1
>>
> 

