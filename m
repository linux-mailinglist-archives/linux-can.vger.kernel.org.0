Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92CA65BEA7D
	for <lists+linux-can@lfdr.de>; Tue, 20 Sep 2022 17:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbiITPrb (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 20 Sep 2022 11:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbiITPra (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 20 Sep 2022 11:47:30 -0400
Received: from mx0a-0054a801.pphosted.com (mx0a-0054a801.pphosted.com [205.220.160.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23A666120
        for <linux-can@vger.kernel.org>; Tue, 20 Sep 2022 08:47:29 -0700 (PDT)
Received: from pps.filterd (m0208802.ppops.net [127.0.0.1])
        by mx0b-0054a801.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28KDuo9Z031394
        for <linux-can@vger.kernel.org>; Tue, 20 Sep 2022 08:47:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsara.com; h=from : to : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=samsaracom06092020;
 bh=zswPk3CHtwiHzo177YaIcxRuK9nrL6M5/aoJQ+qgiPw=;
 b=ZRjqQJcMjU/Zgmr5zVy93cgIa4wGB5YxhQ4+MJKADLoELbT9YyzcOJeaBCOxUTHMPED0
 TQGYCJNUaVEhajfFAU3cJKQ9qy6v+at+ONCmllNQJYvO7AWqkQ4TYjztIStw0MZFCcpW
 DWpZZWapalsvXlKMoDo3af2RKaiz/uF0Fulp1o4xw9do3U0eHB+fwq7DOyFQev9Wif1M
 bnrJirUFCipAUupVIOJOqbrWHjrswuHs6T5JgKS+pKQXaG/rpQca6kBImFilpYWKlOgf
 HdYEvAPS00oHu/Ro2/HYoojrjV/hb/r3ldRUcXEi+a+hVL8qU6wL24SsrIqHFh9wDX9Q cw== 
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
        by mx0b-0054a801.pphosted.com (PPS) with ESMTPS id 3jnbx2tf6s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-can@vger.kernel.org>; Tue, 20 Sep 2022 08:47:29 -0700
Received: by mail-qk1-f200.google.com with SMTP id r14-20020a05620a298e00b006be796b6164so2223700qkp.19
        for <linux-can@vger.kernel.org>; Tue, 20 Sep 2022 08:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=samsara.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=zswPk3CHtwiHzo177YaIcxRuK9nrL6M5/aoJQ+qgiPw=;
        b=GVXFWmsil6kfEsNUTX1g7mSuCrYy+Z6AUH+Ic7yV9JG68CgKbOOKOW37CyrNEh02E4
         9awrK7PF2UCRUugvSzb4Q2UEbk1tIRsg4rnXZ/L15mufFtTIDDtb2L3b5vEEB6bdV+/z
         Z56A6eEggT3B4pQe7oTkQKTV0aBW2JcCTRYn7VireDLVzHRHzzufKj1UF2gH+wbI4n/z
         ayHvpzEps1nvZvU0M2y2UxMabkh625z+5r84XOwCppU5I6bUC5ooa3NAjzgKlyMiHfO6
         xF1c8hA0mIPj5ov02gTo/Wss2ABLl8MajtMrVwvNfsMKq+ULeowgZZEAIA1e0pv3wcx5
         S9uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=zswPk3CHtwiHzo177YaIcxRuK9nrL6M5/aoJQ+qgiPw=;
        b=WZOj5suzR4cw7N6hP4Xn3k58YdCs3wEvyS3lX9v5Jsd30so89Wzp9Niag+5GtNyFPZ
         +zh4KlO9/nEK9bEsdH4OsmMF2iH+7IMN3c168Fdt+iAYKGY4TSYg5Ae8RTkwB/MSOLUc
         xX2ooTlp3t5NamUF8Dav80p5llIPzChM6YtKfkLJZ4vZrWtZzpxbXbAHxT8ZSVOUDUC/
         ROFSuIHfI4X9FzyhrL8ZadgxGBJyR3a0ep5BveEXG/mYJs0ReZt7SIAaxnzDwWG27Y+D
         6R+fFq5Ha1KaSmRIGPS8l4MjOigT6V9lOzNM0LGo3JhBNyOgtvDMRr/3TthiyVcCOC5G
         /s7Q==
X-Gm-Message-State: ACrzQf1m2UNRX1PTAm6Vaf8iMVhlSIaRQmFhTZ6cSItjeycBlMYo6ZZA
        Ba5fb/FVv3DhpdGTjJOVFnw26u/gu0/r5GFCVhz1dCwcnnHjEtyAprgaWGpnl46lqPzxJr75yA/
        3ne41WbWAWvsP6OC9eA4p
X-Received: by 2002:a05:620a:4083:b0:6ce:7e02:5cb8 with SMTP id f3-20020a05620a408300b006ce7e025cb8mr16964183qko.170.1663688847993;
        Tue, 20 Sep 2022 08:47:27 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5NY0O3oO43ud6C+t/piRdiS0seOGKcgaEJY4i70xj7kc0714QEZRg/WYJzyPzAuZOpzsMtgQ==
X-Received: by 2002:a05:620a:4083:b0:6ce:7e02:5cb8 with SMTP id f3-20020a05620a408300b006ce7e025cb8mr16964162qko.170.1663688847680;
        Tue, 20 Sep 2022 08:47:27 -0700 (PDT)
Received: from downhome.. (ec2-184-72-5-93.us-west-1.compute.amazonaws.com. [184.72.5.93])
        by smtp.gmail.com with ESMTPSA id w17-20020ac86b11000000b0035cd6a4ba3csm60615qts.39.2022.09.20.08.47.26
        for <linux-can@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 08:47:26 -0700 (PDT)
From:   Rhett Aultman <rhett.aultman@samsara.com>
To:     linux-can@vger.kernel.org
Subject: [PATCH 0/1] can: gs_usb: remove dma allocations
Date:   Tue, 20 Sep 2022 11:47:23 -0400
Message-Id: <20220920154724.861093-1-rhett.aultman@samsara.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220913204110.89730-1-rhett.aultman@samsara.com>
References: <20220913204110.89730-1-rhett.aultman@samsara.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: u0WEITTgR00KHr2hoftHmhs6gXMZoH3L
X-Proofpoint-GUID: u0WEITTgR00KHr2hoftHmhs6gXMZoH3L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-20_06,2022-09-20_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 mlxscore=0 phishscore=0 mlxlogscore=756 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 suspectscore=0 spamscore=0 bulkscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209200093
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi all,

Please find here an updated patch from Vasanth incorporating Marc's feedback.

Vasanth performed his benchmarking tests again and found no change in the
results, so the remarks in our PDF are still current and valid.

If there aren't any concerns with how we're checking performance without DMA,
then perhaps we should double-check this on an ARM platform and then proceed?


Best,
Rhett Aultman
