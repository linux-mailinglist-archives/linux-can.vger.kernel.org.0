Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D588B5BEA8B
	for <lists+linux-can@lfdr.de>; Tue, 20 Sep 2022 17:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbiITPvG (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 20 Sep 2022 11:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbiITPu6 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 20 Sep 2022 11:50:58 -0400
Received: from mx0b-0054a801.pphosted.com (mx0b-0054a801.pphosted.com [205.220.172.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6760B51A33
        for <linux-can@vger.kernel.org>; Tue, 20 Sep 2022 08:50:48 -0700 (PDT)
Received: from pps.filterd (m0208804.ppops.net [127.0.0.1])
        by mx0b-0054a801.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28KDutEt030726
        for <linux-can@vger.kernel.org>; Tue, 20 Sep 2022 15:50:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsara.com; h=from : date : to :
 subject : in-reply-to : message-id : references : mime-version :
 content-type; s=samsaracom06092020;
 bh=GkPqOyMQcmCqMLz0LgdRFCceWM3Th0ukYvk819AoLeE=;
 b=Bg8uj6BdNR6GtdnXC5Xy7o8+rVcCznAKOVCyn825995Jy+A43REaBsGsMYjE2JRP4ERS
 m9nBOQjR3VUuoG6adslPWJlDn6RhsNPamQ8TzITGxxnLf1/xonwxKGJ9Cx50fwlM6lKw
 8+xlBlm0Eq18n/FBmn2BP/lDhEhTKOeXbx5ztXEI5PAVnf+e7ioe/OKPP9wulb54ZFNp
 DNx+zusNlgxYzwOath0pO/MwM1dV7iYvdHaR+uwJrbg+EfK9HcZEwkSGjHUhFvU2Q7yf
 dqqj0Mgk1V9Qvq6BcM8NdvCFFJlgf21S6/SKtgXeUJ78tZ88VUI82xnCxQildMODWi/C Tw== 
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
        by mx0b-0054a801.pphosted.com (PPS) with ESMTPS id 3jn4u62nc5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-can@vger.kernel.org>; Tue, 20 Sep 2022 15:50:48 +0000
Received: by mail-qv1-f71.google.com with SMTP id y7-20020ad45307000000b004ac7fd46495so2295051qvr.23
        for <linux-can@vger.kernel.org>; Tue, 20 Sep 2022 08:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=samsara.com; s=google;
        h=mime-version:references:message-id:in-reply-to:subject:to:date:from
         :from:to:cc:subject:date;
        bh=GkPqOyMQcmCqMLz0LgdRFCceWM3Th0ukYvk819AoLeE=;
        b=fRpT86k8/Z4RYsZCVWuGmA78/d38S/3cbH1lVgI7n8L0rLF66Y5Rf0Cytlt78iCp+X
         92eX1sM5MnUcjqLp0kqmappF9x3lROG3lnbPFVEuDgt8Sqj02qUHpYzSbw7svF1kp0nm
         DkqZSppS0b7y3WyiHsDk2mEVZz6VACZaqIYtpQ9EC8871HXHbY+dr9TQlkcKIO0rFDrI
         B2TUlkK8hyyEQn5jbgFrhc1Pz2idpLsHLiUnjjP1sLgaBriDiyPEDl++81WnkJvyG/J/
         hPPfPSWrcvskES1hSLrwTCaRe8ig2ziRswW+dhnVExji9KwVAh+kEBz+hEMMZ/p/pMIn
         VA6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:to:date:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=GkPqOyMQcmCqMLz0LgdRFCceWM3Th0ukYvk819AoLeE=;
        b=KrF+atPUUpcUBTkepT0k0Q/+6I/GNrMuceznXUzEPpHy47pOSITXRY0Ru85NV0a2G1
         ZjKAX0hGO/ZsRrY+tTPvn4BdZCjuRl3mRgANmofyBl8INs4nFJb3vCrQVE7RGQpgr0ve
         rsW9Mmjy7Nl887Lgf15LFzSqQKT0q3LiJfGEBYY4X9C+OM1mldn4PpclSx7E+5JE6Zfd
         vX4Zb2W8xCKlDPKZHIuyfBQogftoANCj1K857Riy5BDWYdbu78TXE4amc/BmqHln7yIM
         Fn+KzyKhZzE4OeZekHEGFa+4UICEVAhD5S4j3QhixzA2XxdAXm9RFQSwkeo0iLu7L4Lz
         n9sw==
X-Gm-Message-State: ACrzQf03w+pY9lfBmF1LIhdnvSYd374I/s/UPLyh3uSdsMsYf3u+Prz/
        QHsbDhhzve7Ae21ydMQ/DhbAuF4or9QPT6B6AeYppKMWZ8ZsMhzyPUcQ8gUKme9Xqm2v21GQ5aZ
        k/pwJIliIqvrowXibGxgD
X-Received: by 2002:a37:c49:0:b0:6cc:43ac:a29a with SMTP id 70-20020a370c49000000b006cc43aca29amr16570321qkm.763.1663689047206;
        Tue, 20 Sep 2022 08:50:47 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM79gUcu+vz5o8HHy92Lgg0/hIhow0OuQZi11MlsBrCw1R8qo1bcpdygXhsKNtFcP1a34uvllg==
X-Received: by 2002:a37:c49:0:b0:6cc:43ac:a29a with SMTP id 70-20020a370c49000000b006cc43aca29amr16570266qkm.763.1663689046386;
        Tue, 20 Sep 2022 08:50:46 -0700 (PDT)
Received: from downhome (ec2-184-72-5-93.us-west-1.compute.amazonaws.com. [184.72.5.93])
        by smtp.gmail.com with ESMTPSA id x7-20020a05620a098700b006bc56c063fcsm73282qkx.62.2022.09.20.08.50.45
        for <linux-can@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 08:50:46 -0700 (PDT)
From:   Rhett Aultman <rhett.aultman@samsara.com>
X-Google-Original-From: Rhett Aultman <rhett@samsara.com>
Date:   Tue, 20 Sep 2022 11:50:44 -0400 (EDT)
To:     linux-can@vger.kernel.org
Subject: Re: [PATCH 0/1] can: gs_usb: remove dma allocations
In-Reply-To: <20220920154724.861093-1-rhett.aultman@samsara.com>
Message-ID: <4582a8b5-f238-25a6-86d0-211d1b18f1@samsara.com>
References: <20220913204110.89730-1-rhett.aultman@samsara.com> <20220920154724.861093-1-rhett.aultman@samsara.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Proofpoint-ORIG-GUID: 1hapudbCPDlFnJLCvS_N3qUraPQLUD6v
X-Proofpoint-GUID: 1hapudbCPDlFnJLCvS_N3qUraPQLUD6v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-20_06,2022-09-20_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 mlxlogscore=737 clxscore=1015 malwarescore=0 spamscore=0 suspectscore=0
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209200094
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


Apologies for the mixed-up subject lines.  That's my mistake.

--Rhett

On Tue, 20 Sep 2022, Rhett Aultman wrote:

> Hi all,
>
> Please find here an updated patch from Vasanth incorporating Marc's feedback.
>
> Vasanth performed his benchmarking tests again and found no change in the
> results, so the remarks in our PDF are still current and valid.
>
> If there aren't any concerns with how we're checking performance without DMA,
> then perhaps we should double-check this on an ARM platform and then proceed?
>
>
> Best,
> Rhett Aultman
>
