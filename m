Return-Path: <linux-can+bounces-6581-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +IUDOLkFlWl5KAIAu9opvQ
	(envelope-from <linux-can+bounces-6581-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 18 Feb 2026 01:20:09 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 84932152322
	for <lists+linux-can@lfdr.de>; Wed, 18 Feb 2026 01:20:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C67A1300E5AA
	for <lists+linux-can@lfdr.de>; Wed, 18 Feb 2026 00:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA432356C6;
	Wed, 18 Feb 2026 00:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="c48YLsYh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EjYpwg6C"
X-Original-To: linux-can@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CB521A444
	for <linux-can@vger.kernel.org>; Wed, 18 Feb 2026 00:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771374006; cv=none; b=Y8uFAjHE6ZjcSGt++G5B0s8Xa7aWBEPE26LNSFO9/VorRFBldkwDDM0Oey2kwEFDj+0/ktAyTd95HNL+V8l8BEFpRk3HFOJZExlsgzpeTXl5n4BlXdnIorTvUnm7Fwwm54KeRnYeyN1fgLpR2VYFUPyMOrOp3freR/bN8d6tlNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771374006; c=relaxed/simple;
	bh=V6iozCQ95Dv8lEfZnTIZspabKB0b7mdXpPq2u4KB7ps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KfNyrzTh9zzY+FwElIpuvpUqOtqSB87w8NJR/mCFumWtrxe8LfSmCIE/kogvaSuq46q2GPZ9Ex50Tw5G9ulte0ipzJKwf0iPuZIZt9KbzkQ+F2Y7dCdK1JJZnKGXzzYvclqWI+o3ZRA8PEs3mthuGU01ha1wwxAKZKutln7PU3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=c48YLsYh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EjYpwg6C; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61HJcjVM3380011
	for <linux-can@vger.kernel.org>; Wed, 18 Feb 2026 00:20:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Y9+WLPnbb/gU5vgVspem/ETaRwxExKHepEAhHGJQALc=; b=c48YLsYh5eh4cWWT
	1IlJGAdxTlgxZecvrVp8uWNzWWmQFl9akkFVqb6nCWLiUr9v+JQBeP1lIuEwEiHz
	qSLz/FRIbaL1DbpXD/9vl5eVVoty8x3um8siIJ7cmcWwv5Dz1p4M7FoU3mr5gulk
	MBsRsg1SaJW6EUFxiKt6pPN1QMUDfaIwgI+xFr41x4VLIH7scARaA7ROJTPycmmD
	wxf2CCGvLOHSC1zICEVcmhkvUjNDQQxMBN7Z7DkrxjvYvUR6Kf2tLQTdjRXNAE96
	d/go9tZd82KYHdHvRZhgjg0uXLPqqK56+VYc0P0w1G00137ese6iOXrd3A3Y48Uz
	9W+Jxw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ccxnygsfg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-can@vger.kernel.org>; Wed, 18 Feb 2026 00:20:04 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-506afabb8d3so42112481cf.0
        for <linux-can@vger.kernel.org>; Tue, 17 Feb 2026 16:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771374003; x=1771978803; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Y9+WLPnbb/gU5vgVspem/ETaRwxExKHepEAhHGJQALc=;
        b=EjYpwg6CVQYgIv3hLM6zzjaB4LqxuivoZtoZ+TpfQ6biGoWmY11MsV1HZBjpi3VD4R
         yVytFle0zgFnl24Pj0z5AJOQJNewdJaNewpKGmlg7eIWFq1Eq7KZVDk/YRUqeu/re9wq
         Dv5mkvkO6AcQwk7DEkwUt7NczMX5Dmd9J0KO0jHQNw/WAxXQN5zbsM2a5cCLzCgvPYv1
         7UYu+57U5zquKCNy9dnNv7L4eiZu2UmO/W/F/AhmEQZqjXbd6dp+GbezEPlWOB47jZ8L
         +1BDnOLhsT3I4WcY/eW/lKCuNxBXvkzGPN08b1EX57vMH4/TCLCbsZyWRT7Pj0CJg8x8
         6WJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771374003; x=1771978803;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y9+WLPnbb/gU5vgVspem/ETaRwxExKHepEAhHGJQALc=;
        b=FGcumvSZoMi7ke/SlghvrkQ0Wb6EKtNDprcVtVZHH2ODALAj5wdW0eB5R+xmyxmFNS
         9aFlIoMO7N68QOq/dU9wWNPP8nc4WLRJkL/+KITPy+gLiytK+zSt+TtBiKuyEhgAIrsj
         lJsonTtOgb8wK7MP21rVjggY2g+KKZrpdmOEv2JuYwVAgGvlIJiaDk84cqMAUe8DGAWB
         c8OrORY3TxNHlc2I/BbJ2SQhbTLn/5ZwaFggac9T3zlcBjAlsEO1rA0klNVUCRZx1xJD
         V5VHKb8CqIaFbwEcN1Kl0rnmBj/B6DZV/imWeH1KOybKVgZM45QK+ssqYl2etL27vRkb
         3gJA==
X-Forwarded-Encrypted: i=1; AJvYcCXxZB1xRy71aeL7BQs7E6NLiSLZetO3Q7uhHh5XqHfnc1TN482OXgUasXTwaE8I3dqPMxn+1TQrm3k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwvWJHSi7rbKgq/hNRGopZBsEFNx6XU+C5jmRmPM+nVUGI9Jp+
	JMezT4gRxSpSoOrzhaO5Bshm+QrgbtUdCKekZR/LTr3WEEtuGGbZcBQcrlrKLRYIOj2DksFxVHg
	byG4KxavGKwIyz4o7MOWHLNCGrxLesbEfVn35GFrbhZCSTQnVKfN0bzYhzGY2o40=
X-Gm-Gg: AZuq6aIjRMavEoyLPsGlKlCshuqKCO4e8Q6KseAif5BlPcFWDh1279ykkMazfaA6TYk
	b8Iz80az2bJLHJFYAgWer0HShZRrjoegHnT3kID7O60dtHCkyfWuMKblo5PMmjrlCN/Pzr3g970
	ocMJFhWmUinr7HW+ClWo5okWJtxGJzLEIgfmQ7cp5WJQs3gXR9mpBSoeOfRDuWiRzfTUgZbkZMh
	0/dJBeccuNaYazuNb5ysm4GFrJZbAoRI/t/Dl8THhHUbiS/OzlrDgEb6rkeRpDTz2YNHfbR6ZYk
	Oda5Fll5oxvaCiUiJCrIorxMol7kVy918G/Q38dVfb1oPL2tpkqeGS/uzUrOe08W4xrUuJrBMGl
	x4c/uA9R+7zbEaq0dKJfKvO/2I6D6RA0reZbv/b9JqfRRkA/hpav20enEkeCO6Uq82+3PQBwGps
	PelwnPYqHj7rFwcCvg25a8Vk/7rsxreWQryPg=
X-Received: by 2002:a05:620a:2848:b0:8bb:7886:7e1f with SMTP id af79cd13be357-8cb741b65b2mr27020185a.36.1771374002980;
        Tue, 17 Feb 2026 16:20:02 -0800 (PST)
X-Received: by 2002:a05:620a:2848:b0:8bb:7886:7e1f with SMTP id af79cd13be357-8cb741b65b2mr27017985a.36.1771374002476;
        Tue, 17 Feb 2026 16:20:02 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3870692b7b8sm37129591fa.44.2026.02.17.16.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 16:20:00 -0800 (PST)
Date: Wed, 18 Feb 2026 02:19:57 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>, mkl@pengutronix.de,
        mani@kernel.org, thomas.kopp@microchip.com, mailhol@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        andersson@kernel.org, konradybcio@kernel.org,
        linux-can@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        mukesh.savaliya@oss.qualcomm.com, anup.kulkarni@oss.qualcomm.com
Subject: Re: [PATCH v1 2/2] arm64: dts: qcom: qcs6490-rb3gen2: Enable CAN bus
 controller
Message-ID: <73nfsa3r3isf2shizemroctjpleya4wnnel634g7b5qyvvmze5@vre6wrdxxpet>
References: <20260108125200.2803112-1-viken.dadhaniya@oss.qualcomm.com>
 <20260108125200.2803112-3-viken.dadhaniya@oss.qualcomm.com>
 <n6affntgff5wy4xmm255v5h2ejpepicpz2cybcuvsxmry5td6u@jucskv7zrzvv>
 <5cdfe5a5-3c78-45a2-886c-768b224ad776@oss.qualcomm.com>
 <wbx2qrkhpsntggzqkzkpi4sa6qv3buhkjbwmjoa7zgw2oc4b7u@qugyhcxb6qrh>
 <316fa702-6cd8-4842-aecf-c176a5a53e2e@oss.qualcomm.com>
 <qvuokwiqllm6zmlzj3pfvziylrr5krjya5rnf3ojeycdoutlro@fl5qukh4vorm>
 <5486697e-d02e-4b12-9a60-99d0de343515@oss.qualcomm.com>
 <2ho25tzct6t7gsuyufyg7m4a2ikmblhukb4uddwc7p35wd6yne@heippz3lh4kj>
 <465ab63f-3d0c-46f7-a08e-cdc5fc26b600@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <465ab63f-3d0c-46f7-a08e-cdc5fc26b600@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: v6_lrfV-0Pb4cPK7BnxZ821g9l0OSYc9
X-Authority-Analysis: v=2.4 cv=Do5bOW/+ c=1 sm=1 tr=0 ts=699505b4 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=zTQ9wGJK2aSo1zV0PnYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: v6_lrfV-0Pb4cPK7BnxZ821g9l0OSYc9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE4MDAwMCBTYWx0ZWRfX5/4GJPz6rqFU
 h0iLmXnk5titUpsfamKxt8RR1/aBd53et6OWD5ExHHeN30uY79X9NV99y+27c0579Yn5osnRPID
 ct6M2zHB3cwEYBBuLXv0n7BxCoQKJSQ8TQ9HqstVcSJ70C9QZgdbg/SvEp013NkUZO71VBfYBET
 86J1lwYTx3rY6ht4PDVBt4uRqvgeys2mBisTAUsapF1iWgpP/jxCPWeJjFJM3L8Jta82qsNYQni
 ZjeXCyCzbSEg/u6cBxpLzc/7LXk/UK4NoXN6rGJvL46ENp31xX5i/Hcq0UcZSq4FGpn29vzDhvz
 6tA+ryP9XKtcsIZB9SGVtuXyBhhtUjaHI+8bWbnCiXCyUNtwAMg3N1GXmiNN7eabHbYIUTdxeyt
 bx9fu7KDbqZ63BXX0BvNTxCzdnGoDUzsVSv8pCdTxESZYyFE8hRF+Urna0AgIEp34xkwCo6eQGy
 c4GiODEgKKOzB8wf6Cw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_04,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602180000
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6581-lists,linux-can=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oss.qualcomm.com:dkim];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_RCPT(0.00)[linux-can,dt];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 84932152322
X-Rspamd-Action: no action

On Tue, Feb 17, 2026 at 12:15:12PM +0100, Konrad Dybcio wrote:
> On 2/4/26 2:09 AM, Dmitry Baryshkov wrote:
> > On Tue, Feb 03, 2026 at 05:07:11PM +0530, Viken Dadhaniya wrote:
> >>
> >>
> >> On 1/19/2026 11:59 AM, Dmitry Baryshkov wrote:
> >>> On Mon, Jan 19, 2026 at 10:21:37AM +0530, Viken Dadhaniya wrote:
> >>>>
> >>>>
> >>>> On 1/9/2026 7:35 PM, Dmitry Baryshkov wrote:
> >>>>> On Fri, Jan 09, 2026 at 06:23:39PM +0530, Viken Dadhaniya wrote:
> >>>>>>
> >>>>>>
> >>>>>> On 1/8/2026 7:33 PM, Dmitry Baryshkov wrote:
> >>>>>>> On Thu, Jan 08, 2026 at 06:22:00PM +0530, Viken Dadhaniya wrote:
> >>>>>>>> Enable the MCP2518FD CAN controller on the QCS6490 RB3 Gen2 platform.
> >>>>>>>> The controller is connected via SPI3 and uses a 40 MHz oscillator.
> >>>>>>>> A GPIO hog for GPIO0 is included to configure the CAN transceiver in
> >>>>>>>> Normal mode during boot.
> >>>>>>>
> >>>>>>> The main question is: what is so different between RB3 Gen2 and previous
> >>>>>>> RB boards which also incorporated this CAN controller? Are there any
> >>>>>>> board differences or is it that nobody tested the CAN beforehand?
> >>>>>>>
> >>>>>>
> >>>>>> The behavior is consistent across platforms, but I do not have details on
> >>>>>> how other platforms were tested.
> >>>>>>
> >>>>>> On the RB3Gen2 board, communication with the PCAN interface requires the
> >>>>>> CAN transceiver to be in normal mode. Since the GPIO-controller support
> >>>>>> was recently integrated into the driver, I configured the transceiver using a
> >>>>>> GPIO hog property. Without this configuration, the transceiver is not set
> >>>>>> to normal mode, and CAN communication does not work.
> >>>>>
> >>>>> How do we verify the mode on a running system? I have the boards, but I
> >>>>> don't have anything connected to them over the CAN bus.
> >>>>>
> >>>>> BTW: can you recommend any simple setup to actually test the CAN bus on
> >>>>> those devices?
> >>>>>
> >>>>
> >>>> I tested the CAN controller using the following commands:
> >>>>
> >>>> 1. Loopback Mode Testing (GPIO hog not required)
> >>>>
> >>>> ip link set can0 down
> >>>> ip link set can0 type can bitrate 500000 loopback on
> >>>> ip link set can0 up
> >>>> cansend can0 12345678#1122334455667788_B
> >>>> candump can0
> >>>>
> >>>> 2. Testing with External CAN FD Adapter (PCAN-USB FD)
> >>>
> >>> Thanks! It's price doesn't make it esily available, but it answers the
> >>> most imporant question: by the USB CAN adapter.
> >>>
> >>> Did you add
> >>>
> >>>> A GPIO hog was required to configure the transceiver in normal mode.
> >>>
> >>> I'd phrase it differently: to pull the transceiver out of standby mode.
> >>> By using the GPIO pin you make it always stay in the normal mode. It is
> >>> fine, but it is not optimal. Instead a proper solution would be to use
> >>> the MCP251XFD_REG_IOCON_XSTBYEN bit. Could you please instead implement
> >>> support for setting that bit, based on the DT property.
> >>
> >> Thanks for the suggestion.
> >>
> >> I tested enabling IOCON.XSTBYEN, but on this hardware it doesn’t bring
> >> the transceiver out of standby by itself. With only XSTBYEN set, the bus
> >> remains inactive and no frames reach the CAN adapter. Clearing LAT0
> >> (driving GPIO0 low) is required to put the transceiver into normal mode;
> >> data transfer works only after LAT0 is cleared.
> > 
> > Why? It should be doing exactly what is required. Could you please check
> > the voltage on the pin with the XSTBYEN bit set?
> 
> If I'm interpreting the datasheet correctly, XSTBYEN only muxes the pin
> into its function and does *not* actually impact the operating mode,
> which would match what Viken is observing

See the "Family Reference Manual":

Setting the XSTBYEN bit configures the INT0/GPIO0/XSTBY pin to
automatically control the standby pin of an external CAN transceiver.
The pin is driven high when the MCP25XXFD enters Sleep mode and driven
low when it exits Sleep mode. Standby pin control is not available in
LPM.  IOCON is reset in LPM and GPIO0 will be configured as an input.

> 
> Konrad

-- 
With best wishes
Dmitry

