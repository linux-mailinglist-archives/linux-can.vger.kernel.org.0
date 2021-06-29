Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D373F3B76FD
	for <lists+linux-can@lfdr.de>; Tue, 29 Jun 2021 19:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232343AbhF2RQi (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 29 Jun 2021 13:16:38 -0400
Received: from mail-db8eur05on2138.outbound.protection.outlook.com ([40.107.20.138]:54113
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232308AbhF2RQh (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 29 Jun 2021 13:16:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V6eluzJ/yM5WvS3uVMILoW2+ZCbrIElg1+G4nsDGZlpZcqHcqXLP5sRsGFWJ8cgM0qbWdTSR/dVrVdnkbSISyLVZWuAMXlOXxY46wknPK6yvx8Eu7rhKxcluph8dIqxGnW+MfPe3i/LEejiulneOqMxtlF+S+4VMt92ceGeIi5uqF0WbxAVDbOdndeQe/Y3ppS2wbCMBFq7sFulOAovowQ2njgYIwmDa1ccJxPSvAzjE2gW/JkT6SIG3N5v+XfiHIip0WyLNlPpMCEcxi+MHHAP453KAZU46xwE659YMfWvc3bHd+kj64HWkiqSqm+f4DUIV8fAr3dw/74n16X/WNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pxK1KGASAS6WrRNeL85RsVLkK/hH8f56PIysSs2oh/g=;
 b=OHMCrHwQ8BHdtelN+JpRCf6j+kdBIfOr8r5lNysL4NPRbmSfytUhbA5dVSHoMWaUg9LoBgFqexwXMvBiva4dxm49PY8ex82IvcWNY/lGE5WgHMe4BkiKHCA39f+0y+2vi+2Vv4lacY+64neN7itbQy9V/PUdYQ12E8KIeWXbTtLTGMha19YJokai2NPUaDJ588vO/wDGiJjBNJp5DaRjbSUxEgzXmm0AA3/3m2n7I0nGfNrWsOSeCafOkoLFMuiZ4tKQYenLFIEUsxSYwtKsxaAouycDm52clcNpynrCKfvQyyqkGj3veAScegjSNglmSnrmDFAxbQUiq9RjHcSLMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pxK1KGASAS6WrRNeL85RsVLkK/hH8f56PIysSs2oh/g=;
 b=RKW5W+NyBIGpoiRRh8f04Aa5pKubxVUxT8Gm61WXanRaFQpontefO9prZKgTd4hJE/ZecaO0OyJB1LfvBZVFANgf8vNMWGcSaUNzV8kjbFRSI1SffIMDswKzqA285dJ6h+mWJvB7GffEF6RIgYjE2cl50Fc1KXfdllecL7ZE2EQ=
Authentication-Results: lists.oasis-open.org; dkim=none (message not signed)
 header.d=none;lists.oasis-open.org; dmarc=none action=none
 header.from=opensynergy.com;
Subject: Re: review of virtio-can (was: Re: MSG_CONFIRM RX messages with
 SocketCAN known as unreliable under heavy load?)
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org, virtio-dev@lists.oasis-open.org
References: <c3fc258b-2f62-74ba-ca41-e6f839930020@opensynergy.com>
 <20210618091614.nqcvvmtf4wo4aejm@pengutronix.de>
 <8c76c15d-6252-8af5-01d1-71752cd0cb7b@opensynergy.com>
 <20210625091938.5s7g2eiuz52vx7fh@pengutronix.de>
From:   Harald Mommer <hmo@opensynergy.com>
Message-ID: <8de068d1-b5f1-786a-1dcd-46893ea098e7@opensynergy.com>
Date:   Tue, 29 Jun 2021 19:14:03 +0200
In-Reply-To: <20210625091938.5s7g2eiuz52vx7fh@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM8P190CA0006.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::11) To HE1PR04MB3177.eurprd04.prod.outlook.com
 (2603:10a6:7:24::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 17683980-67e1-47db-31d5-08d93b214c72
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3370:
X-Microsoft-Antispam-PRVS: <HE1PR0402MB33707282FD8C32BBF1D9B190E5029@HE1PR0402MB3370.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A2noc/2kYcGpR2KoK4Mfjzp5qbJ4f1o+WgnHupIGAJlkH2zkoH/393h2U8tgHwpbWBIoFEcawiVokf01xwMnuWwjlbgei6wAGrYNJ73Qrbi1XeMCyW8zAdfIP6t40mYUYYWQTownGVB+A6ooICy2pdkgVUNbaNnE2PonbfR7iK7LkJDSDU8ufHHpiJ/ZYrlcSuTl3WiKQoa/Lf8bY28CDQn5JaczH3ii4qkbP2nrWGnMpgGU7MJcRLtA1auUQoscfjw/5/q9NdT9peGGz5Pk2bvMV+5A+u29PtHq80nQ3UibDU+yk9rI2qxJnEApkC7atOXe9+bkFy4V+BpFsBX/xWHLH2sqOGeuLX/UaJlNkNzScJtAlJCBMkPqJJO+K5aAKVKRw8ek6ntHoukgpXDLTb0DIgV8cGiQIVGOQdWCxnVovmagRmUUngDFyIy/tZ5srEKb/QttXtkp2qVhurcBA5u0R3a6zpgHaUXTUP7IRtw5ADfaPIQoz6xHfAAhBJmrzM3P+ix2SDqwaBsg2W4SorDKxJ+4y49X5B7LWp8dKa9GQEJIAT9YavEn+Zlz2puSK2LPsvWRa8sgkFlUsN9tGBBm5lJHWXG+/hu6apMLVGR9Dq+g8N8pblX+rtUywQD5LceBsBluOwXYGYsQTn/uDC/Rheb4SnFDi0Tp6qxUERiKV7h0Te8mqtUxogKjSve9qtO4HEH+vMqLxDq1xEmAZOZum8TKBiJ6kOBKZcP8yOftJy5KsyI5IM+4ZKm4iaHS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR04MB3177.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(396003)(136003)(366004)(39830400003)(478600001)(2616005)(316002)(966005)(186003)(5660300002)(30864003)(4326008)(31686004)(42186006)(53546011)(83380400001)(36756003)(38100700002)(6916009)(15650500001)(31696002)(66556008)(66946007)(8936002)(26005)(2906002)(66476007)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDRQVHdwQUZqWGdOblVqN290REJ1YjBWaytHc0p6KzJ5b2k5NzRrUjBHVStq?=
 =?utf-8?B?all6NVNXWExrQnp2bk1vNnVGSmY1UWcwRFNHMDFud2h4VDBsNHluT05TdlI3?=
 =?utf-8?B?anFaSkJCbTVjZEdaRHN4QUFuYmQ2ZHlOanl6bmxiOHBWR1ZRdDg3eUgxYk81?=
 =?utf-8?B?N1g3UEZWeTNOVDFvNTJaSE4rTVFjSTlUWUJIcUNTRFNYaTFnajhkMDZqVFkx?=
 =?utf-8?B?VVNXLzZ0YnRraFVKSzd6VmlrTExIUmtZT3JyNTgzOFN4eFk1cDVVbjZUOU5C?=
 =?utf-8?B?YWg4UFRRUlBmU0NsKzMyMVN0YSsxYm1nc2Y1UUVJQ3RmOXJ3Z1Nsak5JenE4?=
 =?utf-8?B?M1diWG43bC84T2lmVkZvK3h3Z2hZM201RzZyRmQxRC9wdXRTNGxuNWRDU29Q?=
 =?utf-8?B?K2VSL3BIYU1RTFBrVFdJRFRvR3M0UFZvaXJRcnVqbGpzNXA0UmtweGp4eWh2?=
 =?utf-8?B?cWxkQXpvWnVjU1VwR0NMZjQ0ZjZmMVpSVmFXOEs4SkN3aW9MSGxlTlpkb3Fh?=
 =?utf-8?B?Ym9VN0JwNXZ2emtJV2gxYzNuOG9qc1NOMVFHL0IrMHZla3VwbXFVOE5FV0w3?=
 =?utf-8?B?T2hFNTB0MzVRTnBuNUFuczFxeVNyMEs4QlhkbnJIeWFqV3p0bWFsWG9GWmpX?=
 =?utf-8?B?ZzliVnJJWTV3Q0NZRWhaM1EyQ3Y0bGd2T2FVQm1FVDdZaHdsajhxeDhFMlZn?=
 =?utf-8?B?cW41aFEwdVh3Z3NKcU9uZmdFN08rNlFpOHA5MDVZL3FNMStsaUx6VkthdTh0?=
 =?utf-8?B?VDE4M0dVb1VKVWtxRFZJcG91eTIwSHMxUlM5OUZxTUxNUWQweVRaaGFGM2Ry?=
 =?utf-8?B?MWZEcDMxKzdKRk10Ry9yU3Q2TG5JLzVxTExiVjZxemR6bFN3SkJ2VnVTVjVJ?=
 =?utf-8?B?Z3lzeGtYSCtzVG5YVThSMVhRV3VERkVhV0dlRUtUbjVMWDFJajVyV3FyK2Rk?=
 =?utf-8?B?dmpNUkNQSnNNaVZ2UW9wTkh4dUtOR0lqN21hNXZ3S1FJWTRqMk1lWEc0d1Ay?=
 =?utf-8?B?NksrZUpCM1B2ODRBaSsvTGxkSWdjcStDaEdyemoxOWdJUS9KNlFURjJYMzQw?=
 =?utf-8?B?dm1VUDZ6Yk9LS2dVYXhPbEdFZS9UZ1Z4eEF2NG1NRVVhSHl3VnZVd0NjclpM?=
 =?utf-8?B?dTEyQ2FYSzFiUDFnTjZGTEpaOWVDTk1ITGU0OUc1MjMwenZMeFM1R1BwUXNK?=
 =?utf-8?B?RkNYeXFLamRFdndxQU5LQUVKRndXUStLM29TNHovK1ltancwOVN5Y292VnB3?=
 =?utf-8?B?MXd3clY1YjVUUHZIVzZtWHMvaFhab2w1Njg3SGk1S2kyV24rb25vZzdicG5M?=
 =?utf-8?B?bGlRdEdRd3VTN0pRSFhBb3JRV1hJT3NydFRzNlZUQk9HczlQMjVkMjlDMTdn?=
 =?utf-8?B?RmUyVDBMcHR2VmRKZVlwQ3ZQS2FQUUtncU1HTHZyaEI4eVF4dEJFL0hpeVR2?=
 =?utf-8?B?bmZPQ3JaQlNFdCt3dmRxK2V0a1J6MFNKTUNRaGlRbENQanpLd3M1dzFOS0FC?=
 =?utf-8?B?UnI0SEJKZVVyU0I1RmJ1dlZwQXNOdjJKWC93Q1dNTFBmSmNFYkRxY1hIWU9B?=
 =?utf-8?B?VFZhbUZMYllnWFZQT3hYakx0MlM0V2wvNWo0ZW9Ic29ZNzVIVlRFUnBzaU9J?=
 =?utf-8?B?VTBvNy9pWENMRUlCMlN5aStjekFYdUZ2YmxTU3dETXRlKytoME15U1FMcHdL?=
 =?utf-8?B?eGJRUVJWajBSeDc4QTkvby9hVk9HdHBaKzBzRllIajIvTTNER0xZNndXU2Nw?=
 =?utf-8?Q?2d4G6EyVa9JLXxJwd4zTrDGdofsBrZZ1Aw/7OID?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17683980-67e1-47db-31d5-08d93b214c72
X-MS-Exchange-CrossTenant-AuthSource: HE1PR04MB3177.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2021 17:14:05.4626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YEly2PBrYkWpvDXTrgZL/rY50DxjkHahM3iDKCcTxubwaznCUw4DbluRQAV/QfIuQbQ7lh5rdH26/M0oIHo+aA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB3370
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello,

Am 25.06.21 um 11:19 schrieb Marc Kleine-Budde:
> On 24.06.2021 17:21:15, Harald Mommer wrote:
>> First draft went to virtio-comment@lists.oasis-open.org and
>> virtio-dev@lists.oasis-open.org.
>>
>> https://markmail.org/search/?q=virtio-can&q=list%3Aorg.oasis-open.lists.virtio-comment#query:virtio-can%20list%3Aorg.oasis-open.lists.virtio-comment+page:1+mid:hdxj35fsthypllkt+state:results
>> [virtio-dev] [PATCH 1/1] [RFC] virtio-can: Add the device specification.
>> Harald Mommer Thu, 01 Apr 2021 08:21:09 -0700
>>
>> virtio-can is a virtual CAN device. It provides a way to give access to
>> a CAN controller from a driver guest. The device is aimed to be used by
>> driver guests running a HLOS as well as by driver guests running a
>> typical RTOS as used in controller environments.
> Let's open the focus of this driver and not limit us to RTOSes.
Not limited to. But usable for the RTOS audience as well.
>>   The CAN dlc is not needed for anything, just like in SocketCAN.---
>>   content.tex      |   1 +
>>   introduction.tex |   3 +
>>   virtio-can.tex   | 245 +++++++++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 249 insertions(+)
>>   create mode 100644 virtio-can.tex
>>
>> diff --git a/content.tex b/content.tex
>> index e536fd4..c1604db 100644
>> --- a/content.tex
>> +++ b/content.tex
>> @@ -6564,6 +6564,7 @@ \subsubsection{Legacy Interface: Framing
>> Requirements}\label{sec:Device
>>   \input{virtio-mem.tex}
>>   \input{virtio-i2c.tex}
>>   \input{virtio-scmi.tex}
>> +\input{virtio-can.tex}
>>   
>>   \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
>>   
>> diff --git a/introduction.tex b/introduction.tex
>> index 7204b24..84ea5c0 100644
>> --- a/introduction.tex
>> +++ b/introduction.tex
>> @@ -79,6 +79,9 @@ \section{Normative References}\label{sec:Normative References}
>>          \phantomsection\label{intro:SCMI}\textbf{[SCMI]} &
>>          Arm System Control and Management Interface, DEN0056,
>>          \newline\url{https://developer.arm.com/docs/den0056/c}, version C and
>> any future revisions\\
>> +       \phantomsection\label{intro:CAN_Driver}\textbf{[CAN Driver]} &
>> +       Specification of CAN Driver -- AUTOSAR CP R20-11,
> As mentioned before don't make this AUTOSAR specific.

Not sure yet whether the AUTOSAR reference should be removed. Going to 
simplify so some things may disappear and this may result in being able 
to do so. Working in this direction.

>> +
>> \newline\url{https://www.autosar.org/fileadmin/user_upload/standards/classic/20-11/AUTOSAR_SWS_CANDriver.pdf}\\
>>   
>>   \end{longtable}
>>   
>> diff --git a/virtio-can.tex b/virtio-can.tex
>> new file mode 100644
>> index 0000000..c343759
>> --- /dev/null
>> +++ b/virtio-can.tex
>> @@ -0,0 +1,245 @@
>> +\section{CAN Device}\label{sec:Device Types / CAN Device}
>> +
>> +virtio-can is a virtio based CAN (Controller Area Network) device. It is
>> +used to give a virtual machine access to a CAN bus. The CAN bus may
>> +either be a physical CAN bus or a virtual CAN bus between virtual
>> +machines or a combination of both.
>> +
>> +This section relies on definitions made by the AUTOSAR
>> +\hyperref[intro:CAN_Driver]{CAN Driver} specification.
> Please refer to the ISO CAN specs.
Next version will contain the ISO specification additionally in the 
references. In the meantime I heavily looked into the ISO spec also so 
this reference will belong into the document anyway.
>> +
>> +\subsection{Device ID}\label{sec:Device Types / CAN Device / Device ID}
>> +
>> +36
>> +
>> +\subsection{Virtqueues}\label{sec:Device Types / CAN Device / Virtqueues}
>> +
>> +\begin{description}
>> +\item[0] Txq
>> +\item[1] Rxq
>> +\item[2] Controlq
>> +\item[3] Indicationq
>> +\end{description}
>> +
>> +The \field{Txq} is used to send CAN packets to the CAN bus.
>> +
>> +The \field{Rxq} is used to receive CAN packets from the CAN bus.
>> +
>> +The \field{Controlq} is used to control the state of the CAN controller.
>> +
>> +The \field{Indicationq} is used to receive unsolicited indications of
>> +CAN controller state changes.
>> +
>> +\subsection{Feature Bits}\label{sec:Device Types / CAN Device / Feature Bits}
>> +
>> +The virtio-can device always supports classic CAN frames with a maximum
>> +payload size of 8 bytes.
>> +
>> +Actual CAN controllers support Extended CAN IDs with 29 bits (CAN~2.0B)
>> +as well as Standard CAN IDs with 11 bits (CAN~2.0A). The support of
>> +CAN~2.0B Extended CAN IDs is considered as mandatory for this
>> +specification.
> Let's make Classical CAN a feature just like CAN-FD. There might be
> Controller Implementations that only support CAN-FD.

Originally it was there in a very first internal version. ISO sais in "1 
Scope" that there are 3 implementation options. In this chapter 
classical CAN is always supported. So I thought "This is not a feature". 
But "10.9.10 Disabling of frame formats" says that a frame format can be 
disabled by configuration. So this is indeed needed as a feature. Was 
mislead by ISO "1 Scope".

>> +
>> +\begin{description}
>> +
>> +\item[VIRTIO_CAN_F_CAN_FD (0)]
>> +
>> +In addition to classic CAN frames the device supports CAN FD frames with
>> +a maximum payload size of 64 bytes.
>>
> OK
>
>> +\end{description}
>> +
>> +\subsection{Device configuration layout}\label{sec:Device Types / CAN Device /
>> Device configuration layout}
>> +
>> +All fields of this configuration are always available and read-only for
>> +the driver.
>> +
>> +\begin{lstlisting}
>> +struct virtio_can_config {
>> +        le16 lo_prio_count;
>> +        le16 hi_prio_count;
>> +};
>> +\end{lstlisting}
> Have you had a look at the virtio-net? There is already support for
> multiple queue pairs. Though, I haven't found any notion of priorities
> among the queues.

I had a look into the network device. Any I have also not found any 
notion that those multiple queues are associated to different priorites.

The block device has optionally also multiple queues. The purpose in the 
block device is that different CPUs can have ideally their own queue 
assigned. This avoids lock operations on the queues avoiding 
bottlenecks. The network device and the block device have in common that 
they are both devices which have to transport an incredible amount of 
data so I suspect that the reason for optional multiple queue support in 
the network device is exactly the same: Performance improvement avoiding 
lock bottlenecks.

>> +
>> +To operate the Virtio CAN device it may be necessary to know some basic
>> +properties of the underlying physical CAN controller hardware and its
>> +configuration.
>> +
>> +Physical CAN controllers may support transmission by putting messages
>> +into FIFOs first and / or by using transmit buffers directly. The user
>> +of the Virtio CAN driver may need to know
>> +
>> +\begin{itemize}
>> +\item Number of TX FIFO places for non time critical CAN messages
>> +\item Number of TX buffers for high priority CAN messages
>> +\end{itemize}
> IMHO the FIFO depth is optional and should be per queue.

In the meantime I believe this part here was over-engineered for a first 
specification draft.

- I see in SocketCAN no support of priorities. Looked into the m_can.c 
driver heavily and also there no indication that priorities are supported.

- I see in m_can.c also no support that I could query for the properties 
of anything (queue depth etc.)

Having an AUTOSAR driver as backend from which the properties are known 
under an RTOS this all could be done. But this is not what can be done 
in the Linux/SocketCAN environment which is used now.

I'm going to remove this, this has no place in a first draft specification.

Not sure whether the usage of different virtio queues for different 
priorities would be benefitial. But if I remove now those stuff (and may 
keep the priority thing open by requiring to set a reserved field to 0) 
no need to decide this now.

>> +
>> +to schedule an optimal transmission of CAN messages. Non time critical
>> +messages may be sent via a FIFO where they may suffer "Inner Priority
>> +Inversion" (\hyperref[intro:CAN_Driver]{CAN Driver} chapter 2.1). High
>> +priority messages are preferably sent directly to a transmit buffer
>> +where they immediately participate in CAN bus arbitration.
>> +
> Let's use multiple queues like Ethernet has.
Ethernet does it (most probably also like block device) for a different 
purpose, not for priorities.
>> +\subsection{Device Initialization}\label{sec:Device Types / CAN Device /
>> Device Initialization}
>> +
>> +\begin{enumerate}
>> +
>> +\item Read the feature bits and negotiate with the device.
>> +
>> +\item Fill the virtqueue \field{Rxq} with empty buffers to be ready for
>> +the reception of CAN messages.
>> +
>> +\item Fill the virtqueue \field{Indicationq} with empty buffers so that
>> +the CAN device is able to provide status change indications to the
>> +virtio CAN driver.
>> +
>> +\item Read the CAN controller properties using the \field{Controlq}.
>> +
>> +\item Start the CAN controller using the \field{Controlq}.
> How does this work on Ethernet?

The part with property reading from the Control Queue is wrong, it's the 
config space. Besides this initialization works always the same using 
virtio. It's a standardized initialisation sequence.

https://docs.oasis-open.org/virtio/virtio/v1.1/csprd01/virtio-v1.1-csprd01.pdf

3.1.1 "Driver Requirements: Device Initialization" is about the feature 
negotation.

And then is

5.1.5 "Device Initialization" for the network device.

Reading feature bits, filling the queues on which something is 
transmitted from the device => driver with empty buffers so that the 
device has something so that it can put in data. Always the same scheme.

Starting and Stopping the CAN controller: I had support of the AUTOSAR 
CAN spec in mind, means Can_SetControllerMode() which allows to start 
and to stop a CAN controller. At first glance the Ethernet device does 
not have anything similar to stop a whole Ethernet controller. The 
Ethernet device supports optionally the stop of reception of all kinds 
of frames, chapter 5.1.6.5.1 "Packet Receive Filtering".

In m_can.c I saw m_can_start() and m_can_stop(). So far so good.

But not only in m_can_set_mode() I saw that only CAN_MODE_START is 
supported. So this is not a bug in m_can.c but something intentional. I 
guess I will receive comments on this attempt to support AUTOSAR 
Can_SetControllerMode(), especially on the stopping part. Smells like 
I've something not gotten.

>> +
>> +\end{enumerate}
>> +
>> +\subsection{Device Operation}\label{sec:Device Types / CAN Device / Device
>> Operation}
>> +
>> +A device operation has an outcome which is described by one of the
>> +following values:
>> +
>> +\begin{lstlisting}
>> +#define VIRTIO_CAN_RESULT_OK     0u
>> +#define VIRTIO_CAN_RESULT_NOT_OK 1u
>> +\end{lstlisting}
>> +
>> +The type of a CAN message identifier is identified by the most
>> +significant 2 bits of the internally used 32 bit value. This matches the
>> +definition for Can_IdType in
> I'm missing RTR messages.
>
> Please don't cramp to much information, or better say any additional
> information in the remaining 3 bits of the 32 bit CAN-id.
>
> You defined a struct for the CAN messages, so add all needed flags to a
> proper flags field.

You are missing RTR frames because my brain is AUTOSAR CAN polluted.

- AUTOSAR CAN does not support RTR frames

- RTR frames were removed from CAN FD, they exist only in classic CAN

=> Are RTR frames an obsolete or a needed feature? I just don't know, 
therefore I ask.

If anyone implements a virtio CAN device on a controller using an 
AUTOSAR CAN driver as backend there is neither support nor need for RTR 
frames. So RTR frames must be considered as an optional feature (flag) 
because they are not doable in all environments.

The bits were defined as in AUTOSAR CAN. Now the CAN FD bit in AUTOSAR 
clashes with the RTR bit for SocketCan. To add all needed flags in an 
own field is fine. No clashes, no problems and one reference less to the 
AUTOSAR CAN driver specification.
>> +\hyperref[intro:CAN_Driver]{CAN Driver} chapter 8.2.3.
>> +
>> +\begin{lstlisting}
>> +#define VIRTIO_CAN_ID_TYPE_STANDARD    0x00000000U
>> +#define VIRTIO_CAN_ID_TYPE_STANDARD_FD 0x40000000U
>> +#define VIRTIO_CAN_ID_TYPE_EXTENDED    0x80000000U
>> +#define VIRTIO_CAN_ID_TYPE_EXTENDED_FD 0xC0000000U
>> +\end{lstlisting}
>> +
>> +\subsubsection{Controller Mode}\label{sec:Device Types / CAN Device / Device
>> Operation / Controller Mode}
>> +
>> +The general format of a request in the \field{Controlq} is
>> +
>> +\begin{lstlisting}
>> +struct virtio_can_control_out {
>> +#define VIRTIO_CAN_SET_CTRL_MODE_START  0x0201u
>> +#define VIRTIO_CAN_SET_CTRL_MODE_STOP   0x0202u
>> +        le16 msg_type;
>> +};
>> +\end{lstlisting}
> How does Ethernet handle this?
As mentioned above, Virtio Ethernet seems not to support a full off of 
the Ethernet controller. But the more interesting question is: How 
should virtio CAN handle this? If this AUTOSAR Can_SetControllerMode() 
start and stop support brings us into trouble then here something has to 
happen. Always on?
>> +
>> +To participate in bus communication the CAN controller must be started
>> +by sending a VIRTIO_CAN_SET_CTRL_MODE_START control message,
>> +to stop participating in bus communication it must be stopped by sending
>> +a VIRTIO_CAN_SET_CTRL_MODE_STOP control message. Both requests are
>> +confirmed by the result of the operation.
>> +
>> +\begin{lstlisting}
>> +struct virtio_can_set_ctrl_mode_in {
>> +        u8 result;
>> +};
>> +\end{lstlisting}
>> +
>> +If the transition succeeded the result shall be VIRTIO_CAN_RESULT_OK
>> +otherwise it shall be VIRTIO_CAN_RESULT_NOT_OK. The request shall be put
>> +into the used queue when the CAN controller finalized the transition to
>> +the requested controller mode.
>> +
>> +A transition to STOPPED state cancels all CAN messages pending for
>> +transmission. A state transition to STOPPED state shall trigger to put
>> +all CAN messages pending for transmission into the used queue with
>> +result VIRTIO_CAN_RESULT_NOT_OK.
>> +
>> +Initially the CAN controller is in STOPPED state.
>> +
>> +\subsubsection{CAN Message Transmission}\label{sec:Device Types / CAN Device /
>> Device Operation / CAN Message Transmission}
>> +
>> +Messages may be transmitted by placing outgoing CAN messages in the
>> +virtqueue \field{Txq}.
>> +
>> +\begin{lstlisting}
>> +struct virtio_can_tx_out {
>> +#define VIRTIO_CAN_TX 0x0001u
>> +        le16 msg_type;
> make this 32 bit and add flags for extended CAN messages, RTR, CAN-FD.
> We have to discuss if we need a bit rate switch flag.
>
>> +        le16 priority;
> Let's handle priority by using different queues.
>
>> +        le32 can_id;
>> +        u8 sdu[];
> Where's the dlc or len information?

I will think about the details, msg_type is everywhere le16 and just 
there in case we need some day to support a totally different message on 
this queue we have not even an idea of today. Somehow I'm preferring to 
spend an own field for the flags.

As 2 priorities should be sufficient this can be a bit in the flags if 
not to be implemented by different TX queues. So instead of "le16 
priority" "le16 flags".

The CAN len is not needed as Virtio provides the message length of the 
whole transmitted message.

CAN len = Virtio message length - offset of sdu[0].

>
> We have to discuss if we want to pass dlc (0x0...0xf for both Classical
> CAN and CAN-FD) or len (0...8 for Classical CAN and 0...64 for CAN-FD).
>
>> +};
>> +
>> +struct virtio_can_tx_in {
>> +        u8 result;
>> +};
>> +\end{lstlisting}
>> +
>> +Priority is 0 for low priority and 1 for high priority CAN messages.
>> +
>> +The actual length of the SDU can be calculated from the length of the device
>> +read-only descriptor.
>> +
>> +To avoid internal priority inversion in the \field{Txq} the user of the
>> +driver may do a book keeping of in flight transmission requests and
>> +defer sending of TX messages until the chosen transmission resource
>> +becomes available.
>> +
>> +If priority, can_id or SDU length are out of range or the CAN controller
>> +is in an invalid state result shall be set to VIRTIO_CAN_RESULT_NOT_OK
>> +and the message shall not be scheduled for transmission. Sending a CAN
>> +message with a priority with 0 transmission places configured shall
>> +be considered as priority being out of range.
>> +
>> +If the parameters are valid the message is scheduled for transmission
>> +and result is set to VIRTIO_CAN_OK. The transmission request should be
>> +put into the used queue after the physical CAN controller acknowledged
>> +the transmission on the CAN bus (may have to be put under a feature flag
>> +as there may be non AUTOSAR CAN driver backends which don't provide a
>> +trigger to do this correctly).
> I think this should me mandatory, but we might have a flag or feature
> flag to indicate the "quality" if the tx done information. Some HW CAN
> devices only provide feedback that they have queued the CAN message, but
> no feedback that they have actually transmitted the message.

Feature flag to be added: VIRTIO_CAN_F_LATE_TX_ACK

And all this config field and priority stuff will be removed. This is 
nothing for the 1st version. Especially because it cannot be tested in 
the SocketCAN environment as there is no support. Let's keep it in mind 
as feature for a subsequent version but forget now about it. 
Overengineered for the 1st shot, wanted too much.

>> +
>> +\subsubsection{CAN Message Reception}\label{sec:Device Types / CAN Device /
>> Device Operation / CAN Message Reception}
>> +
>> +Messages can be received by providing empty incoming buffers to the
>> +virtqueue \field{Rxq}.
>> +
>> +\begin{lstlisting}
>> +struct virtio_can_rx {
>> +#define VIRTIO_CAN_RX 0x0101u
>> +        le16 msg_type;
>> +        le16 reserved;
>> +        le32 can_id;
>> +        u8 sdu[];
>> +};
>> +\end{lstlisting}
>> +
>> +The structure element reserved may in the future be used to forward an
>> +AUTOSAR hoh, see (\hyperref[intro:CAN_Driver]{CAN Driver} chapter 7.6).
>> +The value should be set to 0xFFFF.
> Please remove any AUTOSAR references.
Last remaining. And it's not needed if no rationale for the requirement 
to set the reserved field to 0xFFFF is given. Just wanted to have it out 
of the expected value range if someone wants to use it for that purpose 
later.
>> +
>> +If the feature \field{VIRTIO_CAN_F_CAN_FD} has been negotiated the
>> +maximal possible SDU length is 64, if the feature has not been
>> +negotiated the maximal possible SDU length is 8.
>> +
>> +The actual length of the SDU can be calculated from the length of the
>> +driver read-only descriptor.
>> +
>> +\subsubsection{BusOff Indication}\label{sec:Device Types / CAN Device / Device
>> Operation / BusOff Indication}
>> +
>> +There are certain error conditions so that the physical CAN controller
>> +has to stop participating in CAN communication on the bus. If such an
>> +error condition occurs the device informs the driver about the
>> +unsolicited CAN controller state change by a CAN BusOff indication.
>> +
>> +\begin{lstlisting}
>> +struct virtio_can_busoff_ind {
>> +#define VIRTIO_CAN_BUSOFF_IND 0x0301u
>> +        le16 msg_type;
>> +};
>> +\end{lstlisting}
>> +
>> +After bus-off detection the CAN controller is in STOPPED state. The CAN
>> +module does not participate in bus communication any more so all CAN
>> +messages pending for transmission must be put into the used queue with
>> +result VIRTIO_CAN_RESULT_NOT_OK.
>> -- 
>> 2.17.1

I expected a fat comment about this indication queue here. Using a 
virtio queue just to be able to send a single rare event. We discussed 
internally whether this could be done by writing a status byte to the 
config space but decided against it because of Appendix B.2 in the 
virtio specification which advises against doing so.

And I had additionally AUTOSAR in mind and the polling functions there:

Can_MainFunctionRead() could poll the RX queue while 
Can_MainFunction_BusOff() could poll the indication queue. Clear 
distribution of Can_MainFunctionXXX() duties, nice.

But having seen that a BusOff condition in SocketCAN is done by 
receiving a special error message indicating the BusOff condition 
(CAN_ERR_FLAG / CAN_ERR_BUSOFF) I'm not sure whether having this last 
virtio queue was the best idea. Maybe I should simplify and send this 
indication message via the RX queue and the indication queue is gone. 
Could be that this queue was over-engineering. But this does not decide 
the war now, this is just a detail to think about.

Harald


