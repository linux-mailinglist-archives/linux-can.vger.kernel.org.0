Return-Path: <linux-can+bounces-7073-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNEyFQqvsWmzEQAAu9opvQ
	(envelope-from <linux-can+bounces-7073-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 11 Mar 2026 19:06:02 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA24E26867B
	for <lists+linux-can@lfdr.de>; Wed, 11 Mar 2026 19:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 73AD03076531
	for <lists+linux-can@lfdr.de>; Wed, 11 Mar 2026 18:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A8B3E6DCC;
	Wed, 11 Mar 2026 18:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="RWq+lXXh"
X-Original-To: linux-can@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC1A31717B;
	Wed, 11 Mar 2026 18:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773252350; cv=none; b=HF+++62HdNwJIzBas9qlB9dkFnPQJpIqv77z/vcU8v/sHkcuh5q2B/h07Zpf+ZWYC7zc2ZG9hnAg1kHv6H6E6f0fcWIxavHh/0bFJal8OJk3RGWpj8GRU+zKe9oMPChuzQvtjCB+Uq6cZtpml/RHjEAU1zNH38hlO0+WjmHCICs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773252350; c=relaxed/simple;
	bh=Kl1QGKS/z5ipjt+wRLjUm6f/Z54fY8llcystlxLBd0Q=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=qJrr6o6eIJugsdwwYPC75evLrckFcCRfI94fJURNSGpcryaQ7D+ABPy6iyeJ/96BQeJ2JmtsG2hcg0mZ3fLZVtCNAN4cradgXDskIT1E3KJclzbphuZIKXSgC4N5MNa2UQKx0JhMWlgNesdW+jUg0UUqZ+ytzStiCrD/kkJXjvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=RWq+lXXh; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1773252326; x=1773857126; i=markus.elfring@web.de;
	bh=2KRr+y5CORJ2XNlfWOQPJcOe7Uafynr72d6z/TyjkkI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=RWq+lXXhHvcFKMkhe2jFBNQ7L8Ft7c7V3vfYa6O45iHJNWL9R5l1Mh595gqoK9/H
	 xU5sI7uEL9azAZ5aSjktYrX/zsXHg9BlMPy/UagIGgW252mLFgSo/x4xgGN0IFiEj
	 /KDr/aLh+GTXbh99VYYcZ8EtcOG6jDWnoKcl7oTthASomvhv9c+qB4XWZNy8mB5Zn
	 KEoQTf/7g2lT84s96hjI1I9JN24oSKEUFcVh1RFF9GJQRywFVERUdPQSCm52lZ7Yz
	 BXixyltv2FkK/uaCNr7zE/ne45Jvg0AH1MoCWLF4qIY7qvmf4FzkgJC8exmqbx193
	 czW5NaKieVyEVi7P9g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MVrft-1wA2YF1ydB-00Njkw; Wed, 11
 Mar 2026 19:05:26 +0100
Message-ID: <c032450b-8249-4415-b0e5-cc3e2c863120@web.de>
Date: Wed, 11 Mar 2026 19:05:20 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Wenyuan Li <2063309626@qq.com>, linux-can@vger.kernel.org,
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Alban Bedel <alban.bedel@lht.dlh.de>, Bartosz Golaszewski <brgl@kernel.org>,
 gszhai@bjtu.edu.cn, Jakub Kicinski <kuba@kernel.org>,
 Marco Crivellari <marco.crivellari@suse.com>,
 Maud Spierings <maudspierings@gocontroll.com>,
 Vincent Mailhol <mailhol@kernel.org>, 23120469@bjtu.edu.cn,
 25125332@bjtu.edu.cn, 25125283@bjtu.edu.cn
References: <tencent_6A462B2C8A50BA55116D560D2FFE9EED2D09@qq.com>
Subject: Re: [PATCH] can: mcp251x: add error handling for power enable in open
 and resume
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <tencent_6A462B2C8A50BA55116D560D2FFE9EED2D09@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:csBWvXvZeU+hVGcPXEjQMbzxBStxVyA8mVzuC3EqQkjCHMuK6N/
 d+3uUxpw2sU/xzQ/BWPoqVHvonWIkz6gWG+x7dUSt3Bs/fgXTssLvV/SxL0qRY8ok0Rd3SM
 myKXau+QTomQnzr9E2vNQ+pb26XU9W6DINYJ6sMbZlwXccfIzl6hsx8PpOMM6FLya88zPuD
 4LKPqz9lA1DmPnDJC5qyQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:TLDlVu4F7MY=;g0oOS+CB1JUpCNG0wO3DKpRg3FN
 MwGJ07U670tcI5zfsEkkaEm+JcTV5hcdNN6aeh3z5m46q4heiKpq7HvdXKrED9r9EW26kewad
 bZvXW/MCOW0s1d8zVHursIlHdf1YuNqZcL2PzoYgJmZmJjDpp4aYpbYvia9hkEIUuUm6r4TFt
 iXRGElPv3YO8CA/Y3HrDJsTe4UxCTJJMXa5vhTaMsm9piogl3f5XKUClRkITuzntH0l+Jclj+
 REYe7QfAGtEhUfYE2SCULZZ5SE1RFdNfJHl/M6YHAiT+cErNJn0F0CZdIU87wNi4tf/lTjNhU
 HvM1FPecmz7EuRbqz+qyH+4szXiltUa8kaZRWZRlS0AYXI0lPv0ZqsbAtfGf9jc8NxLKMN+GL
 pzNrE8YHD78EfCQ8EetOj9a4WbI1J6jTP4NgyFf2uSAEs2RmT1qTHHvMFaQE57RjIw2iMAbIj
 mYrvEMqhosNe9g3CGscQUjMvni/ab8fuc+oysI2j31rw97tiuIhRS9+BUywVAjGWALJKjkmm6
 IYm7TLoYqc4EKFT3GaR82czBXMtZbd9zm/0aiJzmnwHOsTvHlkKu3z3Q7fjN/PZdrdgDDIfjD
 NPT1wfV8IvGIo/41NpLwRj9UOS1pEtYrxIeaS9MIMfvS0S7MQPulnrarIKHAA1XBaqdZWKyQA
 4yiRs4MgPx5pxkHVNOzVP8NkXFft1ZBtJzffe8ZAy5P6tEqOW2XG2NPalbsZ/N/+xLvi1NUzv
 OP939DPJiVxb+vwAf6yPcJDvLXo+2kmfw5dDy3AqFIs57EGALmS5E/lbxv6txNWBY6aDPsXRB
 +kiiJLxCuGbUwvVRc+mRG9Iim211c8NLPuOH7wNZ/4+H0sQcZgf39gCfHWp0BW5yJWaLNfF/H
 h0IXUcHATKFLgLIFn0GtahPFNQoNGZU9yrB2H7N2VmfEEDOxW1KGxCi5oFg01c5fp4S+RZ1JU
 CIcCtt71t4/g5/4V6+8nupfarfFlUWKv8eYBJ1BGvYeHMrgPobjzuOXc/iXldmIztbPSKVRNS
 iNMbvRlpOn+URpaAhhWsqjxz2O4W8jJpqLDH63TnwnH4k9SvVVY5nP05gZzighTDcmpqfe46r
 PByO4xxSA1/CAYAPHpA6Lwom+lNrPhLvKVDhANQJCy+4cBsdxx7Kv+w8mxrDtNB5gyaTzfju+
 +nRFS7amu79ypIKIfXIOBjuM7bF3EpNCCQca1olDVnT10XourBFSG6PlOYiOr2d8E++v8yL3O
 SpSKY7ys55v0oNTw1Z6NBS3WBLXUr8yeFBA/La6GEOtwSlOiwpYy6UFy+w2HamdI3iImUFLd9
 EfUyik++fXyrfxLIQtBuf4lMkOPwjcb9E9S1o7ZDiwfVWpp1h/BIQYRl8nhq5GKYjFEuv0pXQ
 SV7ebmnCyOgwXqhBbNra4dnj2zP2WeX0q7fqHXDablt2OyLHTNtXGS7oaDl91dn7lCUk3lyEc
 P95IsbUq3GkGdn+IMZsrtLXVyRynML6p/XIJNPFmZoo5WKSGDEJIW0XAiP3xslokOfAmxFxB9
 oh2BWUFdPwes6mb618nqXuQI9MwgPDcOZEjwM03gKbbZ0oT2HyUmQAJUOgVr5Fo+TsAXPTXQo
 8HEmYYCjij+2bKaPFRhtfJ9r5Oy24KLzyITIynHmKJdkEmWa6MPdj7KhYqH/WEK2rr2UwcwN0
 liKvq7n4FJfXqeqxosy6P1uDeFvIriz78qPN+mCkwahHtIZkuWNoomYAaErAUSSq3tddKaOsg
 m4qX8nPIsgpYGbpzzioInW5Va+i/88x2YbOXGmo97bcGtbH7gLQfGfh+ZU2vFBCiNpaePFj7t
 dZSiSpmmJ6TvegzC3irIMj76SRJ4qnGM+K9sNfiB2Yy5Y5wO4ArwZpeuXDgrO5dokEUQp5YKn
 kAUZQt89qQtdfTgAVIyLKfkpBJbAXk8E9fvHGbgykqV8p0UV05VpHMeByHF165eBc2FUTEs4t
 cLBNHGL8wQGH747Q5BgSdsrMVIIuLeWx73cugtemL4ofPu1+DihQ2JvLV8XN8SMNLkyL18jNq
 Na8EyswHJVMVw0r7LZlHAxIs+LGpnn/lIB080GvPKYfzu1QY7Tj/6U319HsJzoAz7L9LnnJwr
 WNU3UHQN1cyuXdlpwMariG1tfM8gdtzgapV4JJHUID7E2nRrLTPefY3GzC2N02Pfm9X5L3atR
 RxrLxnIdeBewxHDZ3TG8T7xmaVt/BdRgiWeMmA5q/2/VMUedV1i5ZdpZV9KsZUHY1gEeKDnxn
 cEHmN/plaRG9fb7CkIiABmKmZ5fBAiY8FTrle6IcaZ7rtPrtY7mHU4bYSKVWyZLtWOIXcDgxr
 pDrTc538Iu/i8Nvv6/AaSy7MzjmwEloMhrce8qrMlWyZgcylNVCKH9FOdbov3kVmBOdcb8ztZ
 JDcoltwQu+SNxYZDWbpHTlONgb2T5IcW7K8onNN/AndFvkixvf/yDvfm32rs7A3YSA2OH0RHO
 dz7LhxG1B8V90fxYwoVGl/dRMWUDRSpFv4FmE1r8Dnfft8HYDd3jMmyiVZmQFBUCUFLwc66wQ
 4cqn32pMwaTCKLhg0MFGSH0P3MHCu6duFzSqZ/KWyduxnU0oNxKkVnIlk61dwQzLEM+rHMGSM
 enP1pnIosibh0Y5pDERT/qnd18+PJM/w2oMAjoeUPdU7uGV3iEQWolQC3tDbdBrSfuwZE78zp
 IfETPH0BbeNMFScnpk85gtstZ33t2AdbDE6jvG0aRxvKgo5Hb4odUL6+NGkjOmz21DOO0xAYf
 YmoAZazjaythIGuGlYbkIoLZs5Z2v4RWf4eF1ERIFV1m8yQIgknyX6icvvKXaSmNOQ4HeyIjO
 loNaMTZVu29nJWbPzMIcdtC7d9QMmQpRBy5a0aWssOHi0Byrx2KtdGdDk+rb/Y8d4qgAG1fh0
 4iKF37qfHoFnxuxx4EgG8yWtRbH3uNYC0z5/9iUwTOO378LUaJDSdvkuzMKiiVucCH464u2Eu
 F4hee0rGP8En9jlBQ/88iO+g6j5ySdGm7pOoj3ZzckN/GYo1glbugRhf3kZW55EJmHCZQcWiv
 tS90m2ilrrUW/iPO3+rIq73zAj2/udIrsL3oVf1zgGiKMgbogdQW7jWSo2Va8QedpBT/wKohk
 y4vePauCdzRndH89ZtWMdBZSE0mUNhgK4AByP6TMvYVh5B8gCkcdlIv4siABaGAMjc+2mxbzY
 khONmC0+0yDTYVRgb3WM6R9mjG/IzCSIfnXHM/tbhI3lg7DzvrQOeijgrtvKmwv+8kecC+IUN
 ybpesz+Pv8tOcb5NjCykxvwL0jfHeHvYEuLKE9ZTcNiqORvGNiMTmCGRzabYfO4dhrmmFRZio
 XJG1c7yEajES2HidCtZ+WUUzQ6PNtdEQJPh/iVrk3VQwwA7UprBwhuETIvUSel4lsU8RgkIau
 vLs7wbrKQg1sqOMdZ2ODCEzxDueqXIEroPHfOwcGCgmkBNJpFz4i6Tt0Q66AljyE9UPwYG5tI
 zKaShMn8NkrXI/vN9JQjaU8vH1Gd/5MLIrUpdTb5YoV5ZanZis1nvKs7G0GE2ITzpl0GBTsUk
 zSm9FGSGpk3bl2YD6bEqUEGy9RQh2mBvkt+ETszeMH7CkClT2Ym1sPvMhsQbV/LZ0GPtHrcVY
 iudNlohD6NWEhkRoxcyNMk2yIcd9vfC4qtlFtDVxApXvcUdRv9Sb+Xukp7VJU4N/+LMVIeTQb
 QtfRVbIYCIt+et7EBYwaOs3cUctn2E6GQTRvRjPDyxxvRZFzro5Zl8xetBRI7JvpXnziR0V3l
 LQJE2E3qILt9fM2dL963KP5Bc+z5VFcAaSXfMpBP4v/Iz7oGwOHzHqKx63ZH9/yjF7O+VrGtQ
 nQkiejaB6aICF6JCmIrVfq/IMf145mG0TZWRkWwzjkoJeQMsL+Z5HUPodMkvLPwQLsrdQIpfw
 D3oRsxNEjPmV6bEGfE5vFUZ5jl6PLDYQNUzBcKeDTIbPVI3dErLgoiLuwoi2JPnflGrr70sLT
 mAqBmqjKfuEwhzM6GyLZrReVD5ht0VLQCgQ9I0fOTYxYQISrM6ILyDmylONs6JdEJAVsByMhr
 NUOverA6azqx9Ml86SmBMFHPpBJD0vq7yI7/TChesOksmOVqxILvBiRlfkKbIAHVUnGHPuCnH
 4vIVU7q+uo4tzrq19+9MsL58MFgEp970qhnFoYiOY4j1MgjDa8UDFRreaRMUHCe5G2v5+/Rg3
 686bPfUiZsfL16qP4uqhBbdjLh81LXT6K5mMbByNkTFivk8pqIT5PfPSJhKmbG1qtk7o2OvA3
 5hvk+fhIdGrvTBavyeD1CzxPo2oBL2cdhkwpExphYAFUgrAq1kFwKWRviADpXChwT7lvK6BTB
 F4DPexybusqFeIlaAtUw68cHAr9yK/sW4vOqLpFHY2eAedeu95GsKXd2S5e4LJvufJx+lfsGR
 6UN1h6dI9/d/CGkoOEFlsTd4eqFB8u/nSyEg9op9xQuH5631TLU0EbN6HZol8nlJOZmS9Jwpn
 snXMrQa3LQt5VLpmzb2sOuuuhfdS0A/3P+YDdM0MvM2eJoZRtb6pSJaKXWFDHYWDJjAjiMIa1
 bbvI4Yo8YFabWbaX+yaCIx0l0pKYBQ2exv9SRJNdis8sreDCAd+hvN6HWQ864YlVRH3Wl33xH
 Amn8IRPqcXhDDHMW0MyIQIc5COsjW74wM3hRQDQGaw+OcAvw9S5wRFAqMij0TsWTt6S9LrSU/
 /oa4xCL8LlXWhGYsrUzJU1viksyRCOu0lTtw2vDBSG7+X7jld1DAacz8nWYHa78UfgSicsv2/
 VUItpwoZRQOAJHDHTVs6f+Akb/XmcZSiWpAyplF/lokkBZd+tboxsxTxV/jesx0nm2fkVSXiP
 aY7da973OLO2wVTf0vR7HJsDFEZ5/7A0P4SSiId1gq4ijq4HNoNxuOBv0rRbJ72nHvawBJl37
 GpounmTRSDYQLT5Cyf6GSyccm9eT3ko6UjMDPdkpUxyNbny+wR1sSCfikXYf7ANAb0fPF+Eji
 /VvRGLgiWB5cFV7g43vYyZBsbTzfhSBe6rrAG6n6EyDf9wku6BjLqMKKqGjq6FlKNJnAg1n4v
 w8dnTMH9JAQtXyqoLvO8g3OUx58fQJKaj8XhDWDn9/qpYoAbKBGPdV5kdonlTqIBsQNWkbb+e
 K5lu59x7ITOnhIjjxFKpCvP77JfHgOrIf4BGKBti72/DfpQAInY5Q1PV6dx3WCa5Rud7pK7/z
 mUD63vHzrLEpZYQ7Z5wR3DS5OIGUF/oaZ8YopVPIeZskRqHhZKosjRSP0WBz6oQTZYCVIi1Ym
 dIfXwupGzluCSV4R+IXgSpru/Uaom6GiNG3VXw6fAOWpxmrWYNTohzxaNtJp/B0=
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[web.de,quarantine];
	R_DKIM_ALLOW(-0.20)[web.de:s=s29768273];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7073-lists,linux-can=lfdr.de];
	FREEMAIL_FROM(0.00)[web.de];
	FREEMAIL_TO(0.00)[qq.com,vger.kernel.org,pengutronix.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Markus.Elfring@web.de,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[web.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EA24E26867B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> Add missing error handling for mcp251x_power_enable() calls in both
> mcp251x_open() and mcp251x_can_resume() functions.
=E2=80=A6
> In mcp251x_can_resume(), if power enable fails during system resume,
> propagate the error to PM framework and log the error with dev_err()
> for debugging.
=E2=80=A6

How do you think about to add any tags (like =E2=80=9CFixes=E2=80=9D and =
=E2=80=9CCc=E2=80=9D) accordingly?


=E2=80=A6
> @@ -1516,11 +1521,23 @@ static int __maybe_unused mcp251x_can_resume(str=
uct device *dev)
>  {
>  	struct spi_device *spi =3D to_spi_device(dev);
>  	struct mcp251x_priv *priv =3D spi_get_drvdata(spi);
> +	int ret =3D 0;

How do you think about to use the return value at an other place
(at the end)?


> =20
> -	if (priv->after_suspend & AFTER_SUSPEND_POWER)
> -		mcp251x_power_enable(priv->power, 1);
> -	if (priv->after_suspend & AFTER_SUSPEND_UP)
> -		mcp251x_power_enable(priv->transceiver, 1);
=E2=80=A6
> +	if (priv->after_suspend & AFTER_SUSPEND_UP) {
> +		ret =3D mcp251x_power_enable(priv->power, 1);
> +		if (ret) {
> +			dev_err(dev, "Failed to restore power: %d\n", ret);
> +			goto out;
> +		}
> +	}
> =20
>  	if (priv->after_suspend & (AFTER_SUSPEND_POWER | AFTER_SUSPEND_UP))
>  		queue_work(priv->wq, &priv->restart_work);
> @@ -1529,6 +1546,7 @@ static int __maybe_unused mcp251x_can_resume(struc=
t device *dev)
> =20
>  	priv->force_quit =3D 0;
>  	enable_irq(spi->irq);
> +out:
>  	return 0;
> }

Would you like to avoid duplicate source code here?

Regards,
Markus

