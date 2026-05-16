Return-Path: <linux-can+bounces-7639-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePXgOEaGCGoktwMAu9opvQ
	(envelope-from <linux-can+bounces-7639-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sat, 16 May 2026 16:59:18 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 429FA55C34D
	for <lists+linux-can@lfdr.de>; Sat, 16 May 2026 16:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F2D0E300D319
	for <lists+linux-can@lfdr.de>; Sat, 16 May 2026 14:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921A03E2AAF;
	Sat, 16 May 2026 14:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=alexander.hoelzl@gmx.net header.b="UxIaspZg"
X-Original-To: linux-can@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C23C29BDBD;
	Sat, 16 May 2026 14:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778943556; cv=none; b=pb4UTFmjDeAY6yaIjN6DmDRnQAeuXFHtNcDn4xIsJ3LVf+i/Tr5w1dkCls3ISQZiLJmh5x+knGr6nfgyMLYH/fi2XOamqKFC3l72JHRP54QHoKSfrE6hgbdJC/UdHPsdC8wljItNKBtMPjmxVohC0IvAKUO2llJar69l2g86f8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778943556; c=relaxed/simple;
	bh=v9xriwsASNyUx8WJ0LD6OTVHQEoXntD16npj0tmXTuA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pxZ2SUix3IhtcwFphWFasALjT2Vquh+O0xCBivXlwLE/sBWel5zetIW9guXd2X9HsPWeiB0Bc9cTf7VUxF+ML8k7Zh3DAf7j96IydqHPWiQ6jQAV75ZEcPwgcOmX6ZsCTbBB4OKxiwR7LecQjeWvX6aEStkO3ZgO/MwL2eGvTeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=alexander.hoelzl@gmx.net header.b=UxIaspZg; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1778943549; x=1779548349;
	i=alexander.hoelzl@gmx.net;
	bh=kFOgd2UQJL+R1buI4JAkFk6D6nnypZYlBJgZoZjfEtU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=UxIaspZgZW193VZ3YAdDSLawa8MPumiE9lD7+vS6IEleP6dq/+yf0DPJwppL2pru
	 BqwXhXw6ulQOOW+eF9pBxyc05y8CDz1qwv8qMEV/V1MSa86oy/QKRnCMO2hHehuzg
	 IRos/1ufT2qS1BemB8H0OKZqruxsM38wZwXRXPmR/FjNbnJmPFNTWU+UhPCuifPlf
	 Gh10qesoDDcU5GPdzVj6L63tM0ceC2/cJoetMrCUx791CzAxsI5AcfDlDilqNgKPF
	 XkDR34LsssK13cX2ewRTkOEskxaco8ZNE1gCSdnAc/maqzJaWicqBhrwM08uOrfLd
	 eu4JbXjrKdYjMYQlYQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MulmF-1xFoju3L2B-017dpJ; Sat, 16
 May 2026 16:59:09 +0200
Message-ID: <66ed0833-b30a-4f34-a08e-59931cf9d90c@gmx.net>
Date: Sat, 16 May 2026 16:58:56 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Fix J1939 implementation not handling holds correctly
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: robin@protonic.nl, linux-kernel@vger.kernel.org, kernel@pengutronix.de,
 linux-can@vger.kernel.org
References: <20260504221833.53629-1-alexander.hoelzl@gmx.net>
 <aftAQHcRYhw1PO8B@pengutronix.de>
Content-Language: en-US
From: =?UTF-8?Q?Alexander_H=C3=B6lzl?= <alexander.hoelzl@gmx.net>
In-Reply-To: <aftAQHcRYhw1PO8B@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nqllftRO7nBNAsqBqnPiNynlxrGXAi1YvMKpz1queMyMWpejppZ
 mX0PqyC3CjVkf79pnemmRZjcDzTwqHBU8YJJmMcs1QExr+HpNSHdUNs5VyFz0uCgRJ+6STP
 ly6vruCh3oHT7K9b8CxxxyQYtjUljbXrgN5hf5q+1yGyPLiW6NVkahY48//aVFcCCtlUSrU
 eta98N9ZwsuQsdohYloXQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:38ZQAEPAAio=;Kpfl+TWSnsGYf06aAX8e/LaUTkA
 RaL+tPPCcrO9HdwS7kwp9Z2XnLhVEj/f9RBg2hhakKSDltSLpSWEuRqbwqbQ1HTguMe0vdSIu
 esgc/Ahion0G6EJ6A3ma1sHYwojgOEv/jTiSf/gJtJ3Bt3rUszFnl1AZMdLCvzGCNDw6qZcc8
 Ae+3HXUt+FnIjIxhwlIFLuM5K6fgTM6NCG1zGx3512vVzt5jAaNWqG5WsBMz0RaLhX5NRCqjd
 turljgD8Ya3rHzwgWK7cgKj9dJRrD9GwZJekfvEFAd2EG3YFjpeTt6mnmJFXsABcTyRwkaMeI
 lazx6l52qWD6QfT91mcH/cnIMXaV2o98q9xfoPy5+8niTzpRVcenSJo/LtAd6vkzOFH+QiU82
 JOJgTMtmGA8YBPIxlNOs1f+Rf1v1mIBGa8r6d0Z6j3uuzfbtRayOtHOJ2i7E39F8abRWc4VhU
 d3qseOvMe+nmnSUrUpU6FfF6pdo39qsUTKdBQ19kmbHqElq5E55fm2nlc3i1EqMk06sZtq6Bo
 NGvKhCfhvfmigtF+UHHwFHlr26fNFhlgh9xRA0IrqMHeIYcRUBGOPv5Auv0QMW0vVd+uPKdin
 fj9ki8dSfwDeaxq6dorgGkYOMaDQf7vxshFbMKSlasZk/rtIzkMgIlO03vBjz148RgLYcAFo2
 tPTHPVHDAOX1HmkAe1XwbsnQ6FPyphvgA3xgQZTReACI1pU80t502U+1fKQG9mfL/WTtaqOcd
 uZRBIiN7Z8fp/izzxiQC4TM3sqzRpoiv2zvTJyvwSMpVgxnWV7VcpAeERhmO41h11S+VcDbDc
 TppwBmISufPFqib793gGEGRppyszyb33XF1j4tQ9Etp1nZ0KY4P5b7zX2hcojhgL9eC+ohai2
 s4euv7CPs5D6wVbYss6DUgaPM21PNYK/CWpDSEtDiaEUf7PjR5HMtaU+ZAL3qpo6IuB4J3lcE
 6kzRb4Unx31mb3RnE27JrohVjcq96O0sI7BH3c7q1SLgLvsHf/vABl6Fvxfou6D3BJ2rJWr4M
 RzFaC9z27/Xz8ztYr5SlLrNaP1SO0q0Pn7ewMvwuMFrYBEFiz/AUvOOLZ1B8vQyJjXEv499Z6
 8i/krTUCoZDETONNGsuh+pOZ3sWx9Gp4Ceg6FnRIdAWZzEEQOqtsCs9yvyFDe2jatpdAGosTe
 lpcrnd+62+/BndJlV1Q2bDIPUGIcT4UcJqvv+Rg6nyi6iA8XzVOCLnBv3WWnFrm69a8FbpGXn
 D053RWrGODjM3gWAVk111d0T4b0ejHU5RLCFPXgplb7UWbB2onjQLq9k4nnlr8LhVbtMtXhoh
 zQWZpGydoMUjy8S+QrYd4bCiJh6iB1c6QbCb87XnBsMsua1M0hlN7naBtYTkPE3+ziign8sxu
 Q79IbsgWz+Mx25LNy4TpZkZPePEFVaPTYBIknmw4CHYlmx0VOv24xHWhkn4WrB/b5q9gMNVaW
 pCdXE/FdaBBLO1nuRd9+jvU8vT33QtU0ysd8vUY+8OeWZ1oCwOHwtrjYWgzvekNStkzt3DqHO
 M110Em3jkhhfDoSd/QDRD6CMzCrYHf4nO6/5poFcXAWyJNpme0J+P739xJsmrpLElStIKZMUD
 E1Ui9gq8WFbF6omWZiDkWasuQO4XDWUp8je9cdCGjKWQ3479L+MUdAQL92trn5n+wbPpxjmdF
 Fh8IYEecxa9CmUYAXx5eboq7bCpuBmGrGy3xlLFP/+HG7PLRW8MaO1nBdpzvUfdC/nuSp23JD
 n95lzRiovYB43HqBebRWjOnOKjKYGi4vb/0YihJAMQssIkvDytSMcCWLxtlVQoIp7hdS1iTqk
 bdyTD9/D6ObeMyVMYlTOtXQzQFtjEeDH4wkNddhkF5rdIqlnYjaKzBYO4mOLwXb0WuCTnBDRa
 tK4IJw3kSaM6xRc/osIj2xPZU/HExBABTJBQF8NyNGKhwyrooykhhk/PgrYoViwrRinmoTK3+
 HjH6Cipj387IaTgVbzaXuYnQFL/VazxLLXgCKXO+1Oq3JzFF7CaY9qDZZtV2UPWF6i/O2OR+s
 0S0PFOG9cZanhd7J/ZYcSZFW7ZBK/7PUIhEzHU1j6Tj3AX1UDj3LmfHvbipDx6uwZakcWoAnf
 bfmFbdsxP5IAqxIZlbO6svy3tZlmjMDY3vRWu2FYuwVYIwZ+Ru5zI2BssL6fMzxaSgkOayuNG
 XjQa0UO9X9UCvBNUJ1BNVGvkftPVzTVvmh5hV1DAE5dXOBL5tOy4oDrwq/XoflsjDMtrzk+lt
 EKMsMspTEcw6sE9iTCw86S/4IVYEgrRx8UlSrzO+OUZmc1v8DHPFvpjpFODdqICs+nZZE4q97
 YEFouPKmVwve6Ana7w8x5Bqh2vM6wROif9k8LXsq4Z2/r8i+N0Yx5pk0GnIP1Bcto+fqTkPli
 6PY5qakTwDvWudjqtZTW6o0ttL9txrTLLkW274mGLqq84Qe5OarO/xRuak5zw7WkmJsH3m/3h
 q6yddkImIOnuC+8TzafGOcvkrB4e6OTXKtbW3h13TXWTcU8oA0jC8b4oThDX/wqwQKA6JUy5L
 XsWQJQ3K4tp2apO+D4yHEEnap33J7XIjWW9olx+coZd8krR/XIgB7/K1Ku/rdgOL6F1xtLa9w
 tGLz9GO+QxcffjQLxsp0Oi7OpswK3bBmb1u4oOJHUrewG3Agp2CmGeEv2xh/nOQlqzzhfAxjA
 72J3puptKLKfTZSFM7LcW9P8cINguzSNS6ECzw8GwKQWXVuZ1uoreNhM+o6aGXe1xPGmT1R6Y
 pRLrZkFVcJoto3yJkD1WjXIL1nLtExu6hqf7KWQyOod4YQtzrczhVGrsRzj3ibXGJRYrFSzQ4
 HaJS4CcKJLJ8CVH6Z2+urenKbtSCBLbUadPUXczSAvQukFgPkxJFjaVrPK+NQiNy5oCs+v0Wp
 tVhk+KDC0jae5+hKiSl1qMIW8fo8GJKM3ZS3iV2pjjMRkiuHXMwS7qb2qZqofGadpS4KhytqS
 UyR9s5XFD4rmzGar/vhFLajXpc7lzeGSzu8Y79ADQVfeeMpD0qffkSJc9b8TJiqiHs2+U8b5w
 OCB7UI/ulYQr7U6FTLU9FSr2FOehkzuZjmRiav2OzZ27zMzADMEp4VRkkGHPJ7pu+sjdkTSvS
 LoO4OqTxHX5rAl4k53dNmQ4m5FQyjv+JSaD9ibaj/XiEBD2+xF4nQGWfMpg58k3jbkltn0CpN
 4S2bSlJfJcUeSPAs98LK/1cbqIyThayeb585gUU07g3atkX+mQqahZO2Zivwww7fnJ4KWNeIv
 xO7r9zbrBJNjbLE0vLOKUI9xRr87quH6WINcO2xMjNoPQdZ3f/F4W5U0+X+VAgIMcRaSBFqy1
 rvWaPmReSDFGUHm1VMNwpC3U3RFwq8EZOgTrR8Z+X3yLhc/lpZOiw2GxKTPN74LbEzNrU9hbG
 WVBHznmD59KTJzSnOfHxk394xulmMFoIlQBq2b9dwHsXe7F4uwcIbd5Vs5YfyMqW18e4pKKhC
 gj7L6SquPX+Yolp4t1NXHJ7FZy7ftf1c9XbiS/Vfp+Mchrzf+cZaXENch08M+Hsy1CZxAs/Lm
 Dj/RzC8rjyY2Tv87mRJ6oFcpIyat4KgCPofd9fLpBwU0w4elFfI6waB3Uf6HpfCFJNhIdfXUE
 w0dI6NmO0cCWqh9gXH4Xs4bVeiiPA+RoKeaKMKAbZ0KiVN2cLdZwNLXiDC3OStYeKshIQPPxd
 Bt2Ru7HOukwnjYs8s9+xaAEd6frf6wFp2XyMuZIXsqJBkVMMpMZYlMsdbLeooesAmFQ3XpwJt
 JRsFcycLlsm5rdKEWcpy0CrP/H/dfrH9u+3CyY1I0XzuA5BJazgUfgTrKai30UqXRMhr5mDMC
 IeJK3p3Yq5bnB6HE+cfDycB0q/CkPJvkAc/wkhaBVH3NTOkgxHxJPA80SR3aO2xLm+nJRwZRc
 2o/k5AAfM1IH3kg4xCpMMfNHiKbAXDNKPqUv9d74Ivv/opqaSujLZYb2xXfCPyjGp7o59ewXu
 i4ePxwzumLywHRakWOUF65e/mdCI7FjsZeTcAYKgvMX+rN0oXYZXcldBi8fECsn+BUSWHi5Ea
 H61+jImCn1EWMDdliglbdrKGQTQ5uSABriZetvYhlHsHRY91YayVKfyycS7LbR//2hExhUeen
 4KpEQ31cmSMCL/IQoaKMPnQfhPUc4QVSAClKxrbc2y2MlSgcQaFxKZGCIRjowyJbEGZuOaYdl
 XUP7ieiguu8IOP6JYx113HE/H0EwpuKWJhJWsAiP0/e3r//+Hdf/BMQoH4jJnUniUc/aKv9tw
 nOoNQwYxpPYLAgGCQxK7TzkJZJPyf3x3K8d7AUHrrWKSvtaAdN8BxEN4/ZSSHW5ekW+hq28a0
 Q33PB/qO3ZdNRMj8OqBJK/iFByWaxzQXQ+SRMFQjVlY3aCVQz7bupFUPPaWHXVirHoDiP/vzL
 8fSdwdlkm5Oc23cLdUz1Vrajm612k4ZMmkpmq17P1BnlfteIGWq4ALyoQR2fQfBagV8HXsh6F
 UrOEDzQbXKuFpBHXc6zc8Q7QLMccSbCOp+2o6nmHG3ZkykN33osVl7s0etFhM3kfAxsCbzHVp
 eIQNpAXolgp+gEsUmH8q/AChI5CgU78pNumCw31ivp3yCSdmg0b/2OFSh4n2pzInW8ONYRuuj
 jvcULOFN3HoGVPxnbk1AvwzaTJ8MrNCpxGMjcTHTw2lG9hJQoED4yDt1SQOWM/Zki6O0WL0hN
 /4+eMNz+M8WN97xfbZw0wSElFCetCNBBaUTRyBTlINqiC6Yggj7lwWgtWooGqVru8YHtc4b42
 oxnt/fi8h9Dr1pJ4ZzpNlKYa/j5Eo2m8nL+wI/cvXqfFlXOjCwvl1wnDPj8VMOrHxdPk6HK2d
 fLi7w0lUsOi7VA6fC3o138S5dUSKoQLW3R2qma71WA1B7vqs/WqvmMKBs04mSS47bGtmm2ngA
 Ci2fykZZKfpFAByGxiPpLqD+I63JNLqW8l02QFl1K99aTqpSdtKDi/DzTEIUrc8Cecj0J3bMj
 hlRYerr6SVg9hCIZWhkVGIJ+IxwdHrbk0gh4kCf9pZl0xfLXm5OTY4mVVOyQRcER+QImyzpyF
 9jLzo48nsEv5eTAJeRo0Kc/wBXXUatL3gbln2nBt9GvIVeapcQhNSD3OV2r1CFbEKHJUtNyN1
 YS2VX5a/wHmC7DrvZgE9wb0yPU9nvhjGUaVKoApMMww2Vwg1HN+PN0otN/c9TTKzajI5kwOEy
 4Ip7dkM7O0Z4pbCAQN5y3X3XS6x6LpEtYPt9bAPhfCCQv7dxF+QstPw9cN6RApffDqIpPdMnY
 XBxqO4h4a2bIb1XIulL/v3AXXqf6FQ+KOvzZrecGG/mnRGw7z9vCXV5ZVmjgkDoF5OfktVcuo
 ZM1zPkGDbhrWCdqGuZoGbwUpHslyjqJn2wc98INihaggyJpKdCKe8JxHr2wLg7GfuN7jCr7me
 +zS3wSWbsNZGxtAMvOTwgtGJdiHaBhqGe5laz5cmbyP8DJCSQkoH57iO5JB6CZ9Z688A813tI
 inx/bbIqcoDALQuvzVnMyprdfvwgqZd5cM8YLtn55IUIl0eP0i+VSXskZ
X-Rspamd-Queue-Id: 429FA55C34D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.net,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmx.net:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-7639-lists,linux-can=lfdr.de];
	FREEMAIL_FROM(0.00)[gmx.net];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexander.hoelzl@gmx.net,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[gmx.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hi thank you for your review!
I've sent another patch addressing all the points related to the first=20
version of the patch.

On 5/6/26 15:21, Oleksij Rempel wrote:
> On Tue, May 05, 2026 at 12:18:33AM +0200, Alexander H=C3=B6lzl wrote:
>> The J1939 protocol allows the receiver of directed segemented messages
>> to hold the data transfer. The kernel implementation did not handle hol=
d
>> messages correctly was not able to resume from a hold.
>> Additionally the incorrect timeout for a held open connection was
>> changed to 1050ms.
>> Some simple tests for the general protocol behavior have been added.
>>
>> This is just an initial draft I'm just looking for some feedback
>> if the general setup is acceptable.
>>
>> Also I still have some points I'm not sure about.
>> 1. There is no check for the reception of a CTS during an ongoing data
>>     transfer. According to the standard it is illegal, but I dont think
>>     the implementation cares about it. J1939_XTP_ABORT_GENERIC is never
>>     referenced and the previous check I removed only really prevented
>>     consecutive CTS which are legal if they are holds. Should I add a
>>     check for this? This seems to be a slightly different problem so I
>>     did not address it.
>=20
> Current I do not have opinion about this. As long as it is in a separate
> patch with enough explanation and tests - I'm OK.
Ok, I'll think about it and send a patch.>
>> 2. Should userspace be notified about holds? I don't think the standard
>>     gives a maximum 'hold open time' so in theory it could be held
>>     indefinetly. This might be a situation a user could be intrested in
>>     even though it is rather theoretical.
>=20
> Yes, it will be good to have a user space feedback. But, it would block
> resources. Will we get difference scenarios where we still have an open
> session which is blocking other transfers?
>=20
Hm I'm not quite sure if I understand your question, but a J1939 session=
=20
is identified by source and destination address. A hold is only relevant=
=20
for a single unicast session, so receiving hols will only block this=20
specific session. As the kernel will never send holds itself this is=20
only relevant for tx-sessions. So the only thing which could happen, is=20
that a receiver prevents a unicast tx-session from completing by sending=
=20
nonstop holds.
This should not impact other sessions but it will prevent this specific=20
session from completing and therefore restarting another tx RTS/CTS=20
session to the same destination.

The other points I addressed in the v2 patch.

...

>=20
> Best Regards,
> Oleksij

Best Regards and have a nice weekend!

Alexander

