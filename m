Return-Path: <linux-can+bounces-1446-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8549716A4
	for <lists+linux-can@lfdr.de>; Mon,  9 Sep 2024 13:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 665FE282F4B
	for <lists+linux-can@lfdr.de>; Mon,  9 Sep 2024 11:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47451B81C6;
	Mon,  9 Sep 2024 11:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ULDXuJML"
X-Original-To: linux-can@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3461B81BA;
	Mon,  9 Sep 2024 11:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725880848; cv=none; b=F6JfqaYQBbToSSyTYdjEQ9EazWRffyI4WFwkJw5wVWCcxabwAKx3IO4Whgvc5TDloPWtxokOy5CJ2fsMwLr1POkXvqtWH8Q2fpoZyUDnSVpevvKIrqNHL2Usb5nJvUL6VmCTvBRM+oKkDBx1/rDLHOnlCluTKG+hOAy94uLfgS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725880848; c=relaxed/simple;
	bh=xnJr/zsL534VZEk0Nh7lt6toQZM7O+OmyOi3AnZky+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kEzEUq5TtDdkqIMfqCMBdgUYL5KFAUh8DAj/pjQADvpjykwN8pR0/DE9sRQQbjgE6oXljIJGD5t+OcQAmQWakyOjoJiACJ4cripfqQws4xBJM0yoJCd9P1YSmC7ehAnAv3+5lVaWITwZ5Qacucv5tIAdbigKJT5AGx27YHCn4Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ULDXuJML; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4899Jnul030692;
	Mon, 9 Sep 2024 11:20:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FKZfd352d3YrxGnDzNNnk0JqdueJK5oEeG2Wrl9zpkY=; b=ULDXuJML7isiwV0S
	zbnFfWFH3jJ3K4SetyG/nYg2MFlFCa1K8Rp5z8P83suecWxY8BqzG8QtmwPm96RF
	a6fyb0Z4eAL3RACt/G9zvnL0eJ7iNAJTrwKP6AaGYzEi1Yq4+iKp+xbgXES6gwM+
	10gFXxn1O0iNtyao0No35BVnbprE1wku3xWK7OKAYhjT5WKHXyS2ADXiqRqKy8hD
	yP97FPKX1sEd6G3EEqvIovWI/aRguE8leierjFcY9P4JaidQ6o+FTDBgQxxQ4pun
	0o536r3ITvOOyEjvSHKiAbIpc7QCpuGeLKupTKqdLJFo13keDDXYDOcBcrfs6K7W
	hilmAw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41gy5rak48-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Sep 2024 11:20:34 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 489BKOd2032617
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 9 Sep 2024 11:20:24 GMT
Received: from [10.217.219.107] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 9 Sep 2024
 04:20:20 -0700
Message-ID: <43de24a2-1fc4-4c04-a19e-09a11bac52e9@quicinc.com>
Date: Mon, 9 Sep 2024 16:50:07 +0530
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] can: mcp251xfd: Enable transceiver using gpio
To: Marc Kleine-Budde <mkl@pengutronix.de>
CC: <manivannan.sadhasivam@linaro.org>, <thomas.kopp@microchip.com>,
        <mailhol.vincent@wanadoo.fr>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_msavaliy@quicinc.com>,
        <quic_vdadhani@quicinc.com>
References: <20240806090339.785712-1-quic_anupkulk@quicinc.com>
 <20240806-industrious-augmented-crane-44239a-mkl@pengutronix.de>
Content-Language: en-US
From: Anup Kulkarni <quic_anupkulk@quicinc.com>
In-Reply-To: <20240806-industrious-augmented-crane-44239a-mkl@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: y1XjWUsM3S6CmtmXk23SG9WjMG35so1f
X-Proofpoint-ORIG-GUID: y1XjWUsM3S6CmtmXk23SG9WjMG35so1f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 clxscore=1011 malwarescore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 mlxscore=0 impostorscore=0 priorityscore=1501 mlxlogscore=777 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409090091

Thanks Marc, for pointing to the thread.
I have internally validated the given patch, and it works fine for me.
Hence we intend to add only DT related change.

Do you plan to merge it in next release or any time by which I can expect the patch to be merged?
Since my DT change is dependent on the given patch. 

Please let me know if you need any support/help in any further validation of the patch.

regards,
Anup

On 8/7/2024 1:32 AM, Marc Kleine-Budde wrote:
> On 06.08.2024 14:33:39, Anup Kulkarni wrote:
>> Ensure the CAN transceiver is active during mcp251xfd_open() and
>> inactive during mcp251xfd_close() by utilizing
>> mcp251xfd_transceiver_mode(). Adjust GPIO_0 to switch between
>> NORMAL and STANDBY modes of transceiver.
> 
> There is still the gpio support patch pending, which I have to review
> and test.
> 
> https://lore.kernel.org/all/20240522-mcp251xfd-gpio-feature-v3-0-8829970269c5@ew.tq-group.com/
> 
> After this has been merged, we can have a look at this patch.
> 
> It might actually not be needed anymore, as we can describe a CAN
> transceiver switched by a GPIO in the DT. Hopefully we don't run into
> some crazy circular dependencies or similar issues.
> 
> regards,
> Marc
> 


