Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 533A6430FC1
	for <lists+linux-can@lfdr.de>; Mon, 18 Oct 2021 07:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbhJRFhM (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 18 Oct 2021 01:37:12 -0400
Received: from mx6.ucr.edu ([138.23.62.71]:62463 "EHLO mx6.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229848AbhJRFhM (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 18 Oct 2021 01:37:12 -0400
X-Greylist: delayed 425 seconds by postgrey-1.27 at vger.kernel.org; Mon, 18 Oct 2021 01:37:12 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1634535302; x=1666071302;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=QdOrzfgnXC/xRiS/jRRgeLIB2El6k6ZmV9fpb4jP3Ao=;
  b=I1ZCcw6XCJ61FCoRxS+6YBV01tZvdg7gG6rEBFML8T2wJLr90ooaOdSH
   parRDwUeCrb7hoaKQo7QxudRwCreOrOf/Zoq4QopIOQRoeIM5VCXoC0qz
   IbYumbRr+DnFtiz7Umdj2gAL0++vIu9jj8NjGn4k/Mhnhz8asRCvm8HbI
   gEPIfSLCtXvAWf7cuHtooeQDMimxvRaitfT6vJutFYeVxL7GvQ+l84MDs
   0AZOOdyJUSnjhqiMVJ+gbhOX6GZWCcSQ6TJ0K4sAcWRSME6dzIpj1uDor
   jY/AOeGBp10MFGtlfjStowe9fqF0//u5KBtxeFOzzSargsZKDid8VUvid
   w==;
IronPort-SDR: 73Ed39fk5S3BwWFBmslnE0jeEFXL2T0hH3efqd7y45Y03Spv+NxLRoAKOKkFew8kbkAlXAcY8+
 dvTmz+GZ5nD+RL0BdPlLS//8J0uYY06V53ugzx8EQFSGmxgg1xW+b1vl5r1aOTweJKx/z/xDva
 kvRY7pRdARTJQJQlVogada5FNlA1qbB/dBXo5SSkf4x0FnOznQOXLJrauDN+EJxYINFVAx1D38
 5l7jPI7vAcrZ+Cz5SRgs1pzPkBsAS0SA2HBS7ZtvwM7xX5vp3sfuQxtUIjba/VRaqfuG96R+iV
 is8AnN7Aq7WYZhkImVi48ZNa
X-IPAS-Result: =?us-ascii?q?A2EDAAAOBW1hf8fXVdFaGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBggUFAQEBAQsBgVCBT1drhEiII4huA5ZXhUkUgSw8AgkBAQENA?=
 =?us-ascii?q?QE3CAIEAQEDAQOEeQKCTQIlNAkOAQIEAQEBAQMCAwEBAQEBAQMBAQYBAQEBA?=
 =?us-ascii?q?QEFBAEBAhABAYEiC1kLY4FPgXkGBDANgjUpAXRTMwIBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBFgINUmYBAQEBAxIVUhALFQMEKAI0AQUBHAYBDAYCAQEegk8BgwcBB?=
 =?us-ascii?q?AqQUo8ZgQQ9ijhzCX0ygQGDTgGBGoMVAQkNgV0GCQEIei4BhXwTQYNFCYN3J?=
 =?us-ascii?q?4IpgTwMgQmBbj6CYwQYgSQBAQaDLoJpBIwJWwcBPFEIDBhQCIFiQFMBAQGfL?=
 =?us-ascii?q?2CbGYIcAQYCgxYdiHuBT5QVBhQsg2qRcUOQey2VXh+KboFihEGGWYg1KYUJA?=
 =?us-ascii?q?goHBhAjgT6CFTMaJYFsgUsTOwECAQIBDAIBAgECAQIBAgkBAQKOKRaDUIUUh?=
 =?us-ascii?q?WohMwIBATQCBgsBAQMJhWqNNgEB?=
IronPort-PHdr: A9a23:XWJDlxd/zBt72FTNDDddoW/jlGM+tdnLVj580XLHo4xHfqnrxZn+J
 kuXvawr0AWRG9+CurkU1KL/iOPJYSQ4+5GPsXQPItRndiQuroEopTEmG9OPEkbhLfTnPGQQF
 cVGU0J5rTngaRAGUMnxaEfPrXKs8DUcBgvwNRZvJuTyB4Xek9m72/q99pHNfwlEniSxba52I
 Rm5rgjctNQdjJd/JKo21hbHuGZDdf5MxWNvK1KTnhL86dm18ZV+7SleuO8v+tBZX6nicKs2U
 bJXDDI9M2Ao/8LrrgXMTRGO5nQHTGoblAdDDhXf4xH7WpfxtTb6tvZ41SKHM8D6Uaw4VDK/5
 KpwVhTmlDkIOCI48GHPi8x/kqRboA66pxdix4LYeZyZOOZicq/Ye94RWGhPUdtLVyFZH42yc
 YUPAeoCM+hWoYbyqFkBogexCwS3GOPiyCVFimPq0aA0z+osFxzN0gw6H9IJtXTZtNT6NKYIX
 uCy0KbIzSvMb/VL0jj+74jIbw0qrPaDXLNxdsrR1FUjGx7Hg1iLtIzqIymV2v4TvGeG8uptT
 OSigHMopA9tuDag3NssipXXiYIPzFDJ7Tt0zYk6K9CkVEJ2btCqHIdfuiyHKYd4Td4uTn10t
 SonybALp4C3cSsExZkm2xPRZfyKfoyW7hzsVeudPyl1iX1jdbmiiRiy9k2gxff9VsmyyFtKr
 TRKksPKtn8T0xzf8M+HSuFy/ku5wjaO1wHS6uJeLkAwkarUNYQhzqQqmZoLqUTDBTf2mELqj
 KOMakok/e2o5uL6abvlvp+RL5F4hh36P6g0mcGyAf40PhYTU2Wb4+iwybnu8EnhTLlUj/A6j
 rXVvZXbKMsHpqO1HgpY34Q55Bu9ETir1ckXkmMJLF9BfR+KgIfkNlPVL/39AvqwnUignCluy
 v3EI7LuGJTAI33Anbj7Ybpw5EhRwxcpw99F/ZJbELQBLer2Wk/2qdPXEAc0Mxexw+b7ENV90
 Z4eWX6XDq+ZLqzStViI6/oqI+aWZY8VvC/xK+Aq5/LzlHM5l0IRcK2t0JcNZ3C4GfNmI0qdY
 XXymNsODWAKvg8mQOzrjl2NTyJTam6sU64g4jw3EoGrAIfZSoyznbCM3D23EoBSa21CElyMF
 G3nd4SAW/cCciKSJcphnyQLVLmgTI8hyA2iuBL4xrd8M+rb5jcYuYj929do+u3fjQsy+iBsD
 8SBz2GNSHl5nmcJRz8wwaB+rlVxxUuZ3qh+mPFYC9NT6O1TUgsgNp7T0fZ6C9bsVQLFZNuJT
 0ymQtr1SQ02G5gDws4HZUk1K8iriFiD4CuuB74ckv3BTMgr86bY3nH0YdZgwnDU1bgoiVYOQ
 tZGKmCnwKV48l6XT6vAiU7RtKKndKIRmQTQ+GuOhT6Lv0VwSAN2XrjZR3cZZ1uQodmvogvGT
 rmzGfEsOw1p18GPMO1JZ8fvgFEAQ+3sa/rEZGfkq2a5Ah2Iy7XEXo33MzENziLAUBFbux0Y5
 zCLORVoVXTpmH7XEDE7TQGnWEjr6+Qr7SrjFicJ
IronPort-Data: A9a23:qQFWWqrHJzUNODqlfGhz5fseLDpeBmJRYxIvgKrLsJaIsI4StFCzt
 garIBmGPPnbamHye9EiPY62905SvZTWx4djGVM4q38wRHsU8+PIVI+TRqvS04N+DSFioGZPt
 Zh2hgzodZhsJpPkS5PE3oHJ9RGQ74nRLlbHILOCan0ZqTNMEn970Es7wr5h2+aEvPDga++zk
 YKqyyHgEAfNNw5cagr4PIra9XuDFNyr0N8plgRWicJj5TcypFFJZH4rHpxdGlOjKmVi8k9Wc
 M6YpF2x1juxEx7AkbpJmJ6jGqEBaua60QRjFhO68kVt6/RPjnVa70o1CBYTQVxZ0y2LgOBA8
 oxmvoa5Ci1qBafvgPtIBnG0EwkmVUFH0LrOIHz6qcPKikOfIiqqzPJpA0U7e4Yf/46bA0kUr
 a1eeG1LNEnewbvnkdpXScE17ignBNn5O55H4y5I0DrDS/sqXPgvRo2QuIYBgG9g3ZEm8fD2Y
 doHMxZEVRf7ORBKZEkzUs1jgfWwmSyqG9FfgAvN+fBfD3Lo5Ahw1qX9ddHcfPSUSshP2EWVv
 GTL+yL+GB5yCTCE4T+M83bpnuCW2C2iCdNUG7q/+fpnxlaUwwT/FSH6S3Ogr6GhiFGOaugGA
 EcO82kE7pM411S0G4yVswKDnFaIuRsVWtx1GuI86R2Qxqe83+p/LjhbJtKmQIx23PLaVQDGx
 XfSwIy0XW0HXKm9DCPCpu3N/FteLABMdTdaDRLoWzfp9DUKnW3ephfGT9ImCKHsy9OsSGC2z
 DeNoywzwb4UiKbnNplXH3iY01pARbCTFmbZAzk7uEr4vmuVg6b4OOSVBaDzt6ooEWpgZgDpU
 II4s8af9vsSKpqGiTaARu4AdJnwua3ZbGyB3QY3Q8V7n9hIx5JFVdAPiN2ZDBc5WvvohRe0C
 KMukVgAucIJZSvCgVFfMt7tV6zGMpQM5fy8DqyOBja/Spd2cwCD8UlTib24jgjQfLwXufhnY
 /+zKJ7yZV5DUPgP5GfoGo81jOBzrghjlDu7bc2qlHyPjOvODFbLE+ttGAXVNYgRsvjbyDg5B
 v4FaKNmPT0EALOgCsQWmKZPRW03wY8TXsyv9JELK7fee2KL2ggJUpfs/F/oQKQ994w9qwsC1
 ijVtpZwxAWtiHvZBx+Nb3w/OrrjUYwm8CArLysxZQ/382Uoe8Ci4LpGL8k7erwu9epCy/9oT
 qRYJp3bWaoXEjmXqS4AaZTdrZB5cEj5jwy5IHT3ajYIf6lmSlGb4dTjZAbuqXcDV3Llqcskr
 rS8/QrHWp5fFR96BcPbZav3nVO8tHQQgsxoWE7MLoUBcUng6tE3eTzjieJvep4kNB7ZgDaWy
 l/OUxsfoODMpa4z8cXI2P3Z99zyTbMmExMDTWfB7LuwOS3LxUaZwNdNALSSYDTQdGLo46H+N
 +9b+O6iYvcJq1Z9tYchQa1gyrgz5oaxquYCnBhkBnjCc3+iFqhkfiudxcBKu6BAmu1ZtA+xV
 h7d89VWI+/VasbsEVpUPAV8K+rahKBSlT7V4vA4Zk794XYvrraAVExTOTiKiTBcfOQpatJ7m
 b95tZ5E8RG7hzorLs2C0nJe+VOKIyFSSK4grJwbXNLmh1Z50F1EepCAWCb67IvVN4dJO0guZ
 yeb3e/M3uUNgEXFdHU3GD7G2u8E3cYCvxVDzVkjIVWVm4qa2qVmgkUJqTlnHB5Iyhhn0v5oP
 jQ5PUNCI6jTrSxjg9JOXjzxFgxMbPFDFpcdF7fdeLXlcnSV
IronPort-HdrOrdr: A9a23:l+8zGqHBORGB9EukpLqEzceALOsnbusQ8zAXPo5KOHlom7+j5r
 yTdZMgpGDJYVcqKQwdcL+7SdC9qB/nhPlICMwqTM2ftWrdyRCVxeNZnO3fKlTbckWUltK1l5
 0QF5SWYOeQMbEQt7eY3ODXKadD/DDKytHRuQ4c9RpQpMNRAZ2IIz0XNu9TKCEZeDV7
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.85,381,1624345200"; 
   d="scan'208";a="251140839"
Received: from mail-pg1-f199.google.com ([209.85.215.199])
  by smtpmx6.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Oct 2021 22:27:54 -0700
Received: by mail-pg1-f199.google.com with SMTP id q23-20020a6562570000b029023cbfb4fd73so9072627pgv.14
        for <linux-can@vger.kernel.org>; Sun, 17 Oct 2021 22:27:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kiah+c1+K/h29ZQ558Kn7ByIUGcE4hwZOtgP7WBVrUA=;
        b=Ew5ajCIcmWGfmPBe1yf5lzaNf4DEVgvOG6sdc2XA/CJdZI/3dZTOn0uGeCO4QosbFf
         s2BLFAPhbixyjkedTMWIRHExFztOnHMT3GuPdFq7e4wRRb+rkriS5INgCgJ0CHXa7Vgb
         8oeItgJKHirv0mOweq2vbPlPbAiAKUnTf1Sy0YJwxY17Fz66063pawypZCi2tp3XJTqK
         XIG1KEMYtGzmjGV638p+/lcqCFHF0wp7ZgXk9oxAG/T4YBftHu9dRwOmMjfqM5on+0/1
         2n8/jV/npXaOiD2uz4Le7AT0ZC1emAjoLMux+AOAO7BKyckz/cTnnstEyQOnqiDhFaQp
         WIlA==
X-Gm-Message-State: AOAM532MeKU833XQVe5DpXCz0ask6sHgQtVIGbEX0BE3ogxRc7VizZi8
        i2XmieDQ847OC1kS3D7QDu+qtdt+gvhrSymeMCi/KeVW5CXPaukzxECrT1wOT7eW6YTwlca9y1S
        WnJ7DdbbyJKGJnX1kCaZCfw==
X-Received: by 2002:a17:90b:1c8f:: with SMTP id oo15mr30388759pjb.169.1634534873870;
        Sun, 17 Oct 2021 22:27:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxDyYDbCwYkuJRDFSd/jQry6S43REUJ3tlMz3VmWO7NZqixbgQeeNja3HFEnLhdtOwWlQTKzA==
X-Received: by 2002:a17:90b:1c8f:: with SMTP id oo15mr30388731pjb.169.1634534873517;
        Sun, 17 Oct 2021 22:27:53 -0700 (PDT)
Received: from ?IPv6:2600:6c51:7a7e:daf9:447b:4e02:7da6:8a04? ([2600:6c51:7a7e:daf9:447b:4e02:7da6:8a04])
        by smtp.gmail.com with ESMTPSA id y203sm11858971pfc.0.2021.10.17.22.27.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Oct 2021 22:27:53 -0700 (PDT)
Subject: Re: [PATCH] can: j1939: j1939_session_deactivate(): fix potential UAF
 access
To:     "Ziyang Xuan (William)" <william.xuanziyang@huawei.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can@vger.kernel.org
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>
References: <20211017120158.2024996-1-mkl@pengutronix.de>
 <6d784d3f-2eae-8569-0266-47142ffe5d1f@huawei.com>
From:   Xiaochen Zou <xzou017@ucr.edu>
Message-ID: <e752f07d-cddd-5225-638d-703159790254@ucr.edu>
Date:   Sun, 17 Oct 2021 22:27:51 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <6d784d3f-2eae-8569-0266-47142ffe5d1f@huawei.com>
Content-Type: text/plain; charset=gbk
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi,
I found this bug when skimming the source code, so there is no concrete
test case right now. Probably it's just like you said, the buggy
scenario does not exist in current kernel control flow. I'm not familiar
with the logic of this module thigh, but will we guarantee that future
code won't make this possible if someone didn't follow some specific
manners?

On 10/17/2021 8:06 PM, Ziyang Xuan (William) wrote:
>> From: Xiaochen Zou <xzou017@ucr.edu>
>>
>> Both session and session->priv may be freed in
>> j1939_session_deactivate_locked(). It leads to potential UAF read and
>> write in j1939_session_list_unlock(). The free chain is:
>>
>> | j1939_session_deactivate_locked() ->
>> | j1939_session_put() ->
>> | __j1939_session_release() ->
>> | j1939_session_destroy()
>>
>> To fix this bug, move the j1939_session_put() behind
>> j1939_session_deactivate_locked(), and guard it with a check of active
>> since the session would be freed only if active is true.
>>
>> Link: https://lore.kernel.org/all/CAE1SXrv3Ouwt4Y9NEWGi0WO701w1YP1ruMSxraZr4PZTGsUZgg@mail.gmail.com
>> Link: https://lore.kernel.org/all/aa64ef28-35d8-9deb-2756-8080296b7e3e@ucr.edu
>> Cc: Ziyang Xuan <william.xuanziyang@huawei.com>
>> Cc: Oleksij Rempel <o.rempel@pengutronix.de>
>> Signed-off-by: Xiaochen Zou <xzou017@ucr.edu>
>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>> ---
>> Hello,
>>
>> I picked up the patch from Xiaochen Zou. I think it is the proposed
>> fix for:
>>
>> | https://syzkaller.appspot.com/bug?extid=a47537d3964ef6c874e1
>>
>>
>> It turned out that
>>
>> | 0c71437dd50d can: j1939: j1939_session_deactivate(): clarify lifetime of session object                                                                                                                                                                         
>>
>> is wrong, and should be removed, as Ziyang Xuan proposed in:
>>
>> | https://lore.kernel.org/all/20210906094200.95868-1-william.xuanziyang@huawei.com
>>
>> Ziyang Xuan, Oleksij, can you have a look at Xiaochen Zou's patch and
>> give me an Ack, then I'll take both patches upstream.
>>
>> regards,
>> Marc
> 
> I think the session kref >= 2 when it is active state. The j1939_session_put() in
> j1939_session_deactivate_locked() will not trigger __j1939_session_release() to free
> session.
> 
> 0c71437dd50d ("can: j1939: j1939_session_deactivate(): clarify lifetime of session object") just
> only partly wrong. j1939_session_deactivate() is called not only when session is active, it may be
> called when session is not active already.
> 
> And I think the 0c71437dd50d may be the real fix for:
> https://syzkaller.appspot.com/bug?extid=a47537d3964ef6c874e1
> 
> I can not find an exact scenario as Xiaochen Zou's patch mentioned. So I can not agree.
> 
> Or can you give an exact scenario @Xiaochen Zou.
> 
> Thank you!
> 
>>
>> net/can/j1939/transport.c | 8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
>> index dc3c30810833..35530b09c84f 100644
>> --- a/net/can/j1939/transport.c
>> +++ b/net/can/j1939/transport.c
>> @@ -1072,7 +1072,6 @@ static bool j1939_session_deactivate_locked(struct j1939_session *session)
>>  
>>  		list_del_init(&session->active_session_list_entry);
>>  		session->state = J1939_SESSION_DONE;
>> -		j1939_session_put(session);
>>  	}
>>  
>>  	return active;
>> @@ -1086,6 +1085,8 @@ static bool j1939_session_deactivate(struct j1939_session *session)
>>  	j1939_session_list_lock(priv);
>>  	active = j1939_session_deactivate_locked(session);
>>  	j1939_session_list_unlock(priv);
>> +	if (active)
>> +		j1939_session_put(session);
>>  
>>  	return active;
>>  }
>> @@ -2152,6 +2153,7 @@ void j1939_simple_recv(struct j1939_priv *priv, struct sk_buff *skb)
>>  int j1939_cancel_active_session(struct j1939_priv *priv, struct sock *sk)
>>  {
>>  	struct j1939_session *session, *saved;
>> +	bool active;
>>  
>>  	netdev_dbg(priv->ndev, "%s, sk: %p\n", __func__, sk);
>>  	j1939_session_list_lock(priv);
>> @@ -2165,7 +2167,9 @@ int j1939_cancel_active_session(struct j1939_priv *priv, struct sock *sk)
>>  				j1939_session_put(session);
>>  
>>  			session->err = ESHUTDOWN;
>> -			j1939_session_deactivate_locked(session);
>> +			active = j1939_session_deactivate_locked(session);
>> +			if (active)
>> +				j1939_session_put(session);
>>  		}
>>  	}
>>  	j1939_session_list_unlock(priv);
>>
