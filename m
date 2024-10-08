Return-Path: <linux-can+bounces-1612-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DAFE39952F6
	for <lists+linux-can@lfdr.de>; Tue,  8 Oct 2024 17:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2449B2C498
	for <lists+linux-can@lfdr.de>; Tue,  8 Oct 2024 14:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C5D18CBE6;
	Tue,  8 Oct 2024 14:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stackav.com header.i=@stackav.com header.b="Dg7MfTB+";
	dkim=pass (2048-bit key) header.d=stackav.com header.i=@stackav.com header.b="YnhkY7OJ"
X-Original-To: linux-can@vger.kernel.org
Received: from mx0a-0087a801.pphosted.com (mx0a-0087a801.pphosted.com [148.163.150.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEF01DF274
	for <linux-can@vger.kernel.org>; Tue,  8 Oct 2024 14:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.150.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728399443; cv=none; b=oW1HUt7kRsA3r6n9mv3dgtn1SnTMHkv0e/00OOYM8tlcDUa9D2i1BQ3jn6ReBajzMKA2Wy7z8PDCgUecajQOEBAajsUhcdRr9CkX4YMAAbuy2KAhsykYTjoadC8gd+HzyRISlLPZ3fVp69ubVQhdYUSgiIHPv7u0hDghJr7A/90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728399443; c=relaxed/simple;
	bh=rcV2/AJw6HIKu9sD7a8r59pk08LFGoMpm3KNqnvJdE4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=CuRUMowmqlbDIy52cKA9d7BlKYojbb6/UL1fP1Onj17pmwHRNPvtRPZ6P8HXtheKOgvgJn5GMgeAXlbzOkNJeLfAOsiVRZeK96CvEHGZtWuXX1B1LBmHi6Uhu4cnYzc5exZ2CTi0Hn3G+AGf5YyiZdoxy4+TKfQReQJ7ed5ioZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=stackav.com; spf=pass smtp.mailfrom=stackav.com; dkim=pass (2048-bit key) header.d=stackav.com header.i=@stackav.com header.b=Dg7MfTB+; dkim=pass (2048-bit key) header.d=stackav.com header.i=@stackav.com header.b=YnhkY7OJ; arc=none smtp.client-ip=148.163.150.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=stackav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stackav.com
Received: from pps.filterd (m0359993.ppops.net [127.0.0.1])
	by mx0a-0087a801.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 498Cmhtb001434
	for <linux-can@vger.kernel.org>; Tue, 8 Oct 2024 14:57:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stackav.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	pps-07072023; bh=rcV2/AJw6HIKu9sD7a8r59pk08LFGoMpm3KNqnvJdE4=; b=
	Dg7MfTB+q5lI0xQkI4wcstFymKZnePlYpOnKAP4jmwEObYsLhesabPlU1DrUjSEE
	RWb5EQ9TR0LNq0UrjBuphqGxNGmXMYMfNX86Rnr55S9HqiI5rvJ7dNasXhKmM5sr
	dd1TGBS1n6m2kB/M1gs0iEf4Qaw4Z+nV8LadHbQ+BXmnXp4ah5goqhdz/FPfiZFl
	7cqR0znAHD2/+/y06278ylnw+MnKiHPNWjb3WDMqxt3U/iTBMYHzooseBS2GTCEM
	LbLWGy6ZeBYzKsEeKx9hFNfbxyk6clqYVt8HhHLG2+4sgIWQtej05/N8WgRriyb2
	EL8lATTYf5IFDtCHdosQ5w==
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com [209.85.219.197])
	by mx0a-0087a801.pphosted.com (PPS) with ESMTPS id 423g3uh3ax-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-can@vger.kernel.org>; Tue, 08 Oct 2024 14:57:20 +0000 (GMT)
Received: by mail-yb1-f197.google.com with SMTP id 3f1490d57ef6-e25cfee6581so9772033276.2
        for <linux-can@vger.kernel.org>; Tue, 08 Oct 2024 07:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=stackav.com; s=google; t=1728399439; x=1729004239; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rcV2/AJw6HIKu9sD7a8r59pk08LFGoMpm3KNqnvJdE4=;
        b=YnhkY7OJ2Khhc59oVYjrSEjAAHgDae8uVZf6CiDl0eZYakADxIMN6w8I1/cSLgEv/6
         CWlhOfunFpD63lDPO8Tc9GvowSaMVNA+ieM4WJFXUiT2bM1UwhuVvxVdVey1sz6IfYj3
         fHdHpGJbJ4p0cUq8pVZ27DvL+x5jKf1cmUInwuXPR1o3WUJPh7IDk8jGqqWmjvDXPYKo
         5GkOjU5xnFCctJsDyJVG6AGkd65KI6wekJHoKIB/+fO6epbhHJsWNJLDqGoZjs4js19W
         +bXwrWWsvtUgGNgTq0wCMeDo4nVKnrJXhfei+cmr4s6EPzOv7CZQ2AhwpCqzLsN4+Bsa
         Kupg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728399439; x=1729004239;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rcV2/AJw6HIKu9sD7a8r59pk08LFGoMpm3KNqnvJdE4=;
        b=QaD+55t1dRxw3+R2IOc8My2TpgzuCpP0kplsaaA0Z02RTEoDRhZ8TXMaBH2fYVdRTc
         DaR83qWUH60HOzlDEVntzzdRiDujhKkBbSjZpBYeTwZmImLBVUT3VKpDJgvd944VQthO
         ce3c3uN0DrnALbql5r2KnQZ0XZLGobbNQ8DzAPcHas1IKAuge8dICqyoUyIDZS1HYX2E
         67thmomG3W4RVU9KhMyRNPxUmj0YRxPSA8MPP0qyTiN/B+rhJN/ZNqOQEDlIr0VRqIax
         KGiIh60uSV/hX72LRN/iFob6ZvwzWtGql4I2RVdbJ2HSvLHCiNFtan4S7+kMez1is7Ms
         bSMw==
X-Gm-Message-State: AOJu0YzG2+mWs7SGVmcC8E2eMSWB7XeufVobELDmLboCSd0Ppnc3ykur
	JFHj4sB8NyHR05YAaD2XxIHZ9MEA1enq5sBQUlzJhjKne6n0arLS1ulUe/2hbgMa2aBvFuPqTjR
	me+5wP++T5iZr4WI5/iROCDg3FNJJK+lp16p4cA3aiEq4wgZF6Wt7qG8ZFEDT0sIw47fdDGniqA
	WMORIaz42LQSHF+5tHTbTT0g0JffcEEpKWvHzE45IxnEpS7Lg=
X-Received: by 2002:a05:6902:1b07:b0:e26:b9f:1a3c with SMTP id 3f1490d57ef6-e28939451bemr9398758276.55.1728399439437;
        Tue, 08 Oct 2024 07:57:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFoMGI13mRQNeWAifpK8ghGKqgTdlexflqPutfM82l5wKFZhmfcUJriA34CYCCB1pSb7XgNl7yrF9Kr4TZEA8=
X-Received: by 2002:a05:6902:1b07:b0:e26:b9f:1a3c with SMTP id
 3f1490d57ef6-e28939451bemr9398744276.55.1728399439088; Tue, 08 Oct 2024
 07:57:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ilan Biala <ibiala@stackav.com>
Date: Tue, 8 Oct 2024 09:56:43 -0500
Message-ID: <CAO7FjJE-opA-ZHSYOTAw1G1uWpX7Esqj-REid=RVccf_YKJ4vw@mail.gmail.com>
Subject: Predictable network device names for CAN devices
To: linux-can@vger.kernel.org
Cc: Ilan Biala <ilanbiala@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-ORIG-GUID: aO1W25Cp1N8jn5ba5TnG6nFInFVRtbZx
X-Proofpoint-GUID: aO1W25Cp1N8jn5ba5TnG6nFInFVRtbZx
X-Authority-Analysis: v=2.4 cv=R9xRGsRX c=1 sm=1 tr=0 ts=67054850 cx=c_pps a=5rZgxjGdQ1phXw1xqkF1vg==:117 a=IkcTkHD0fZMA:10 a=DAUX931o1VcA:10 a=RPcLvomdWzwA:10 a=W1cpKyjbAAAA:8 a=FxQLpf7-28zeSCdVbcAA:9 a=QEXdDO2ut3YA:10 a=FvMT9AR2qkiEEVpopuB7:22
 a=8ejYFKTGWoT5PyFRbCS0:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-08_13,2024-10-08_01,2024-09-30_01

Hi,

I'm working with multiple CAN network devices across multiple physical
USB CAN hardware devices, and I'd like to have them leverage Linux's
predictable network interface device names if possible, but it seems
like it is not supported (reading between the lines of many other
pages omitting mention of CAN, and also using
udevadm info --export --query=property --path=/sys/class/net to
compare Ethernet and CAN device properties).

Could someone provide some details on whether this works, if it is
possible another way, or if it is possible to submit a feature request
for a future kernel release?

Apologies in advance if this is not the best way to reach out, but I
could not find a better method on the SocketCAN documentation website
or the Linux MAINTAINERS file.

Thanks,
Ilan Biala
Staff Hardware Engineer
e: ibiala@stackav.com

